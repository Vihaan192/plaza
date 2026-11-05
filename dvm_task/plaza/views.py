from django.shortcuts import render,redirect,get_object_or_404
from django.contrib.auth.decorators import login_required,user_passes_test
from django.core.exceptions import PermissionDenied
from django.db.models import Sum
from .models import *
from django.db import transaction
from django.utils.dateparse import parse_date
from django.utils import timezone
from django.contrib import messages
from django.contrib.auth import get_user_model
from decimal import Decimal
from .forms import EventCreationForm, ScheduleFormSet

@login_required
def home_view(request):
    org =  request.user.groups.filter(name = "Organization").exists()
    events = Event.objects.filter(end_time__gt=timezone.now()).order_by("end_time")[:5]
    latest_bookings = []
    if request.user.is_authenticated:
        latest_bookings = TicketBooking.objects.filter(
            user=request.user # or attendee=request.user depending on your field name
        ).select_related('event').order_by('-id')[:5]
    return render(request, 'home.html', {
        'org' :  org,
        'events': events,
        'latest_bookings' : latest_bookings,
    })

@login_required
def account_view(request):
    transactions = request.user.transactions.all().order_by('-created_at') # leading - sorts by descending orderr
    credits = transactions.filter(transaction_type='CREDIT').aggregate(Sum('amount'))['amount__sum'] or 0
    debits = transactions.filter(transaction_type='DEBIT').aggregate(Sum('amount'))['amount__sum'] or 0
    balance = credits - debits

    return render(request, 'account.html', {
        'transactions': transactions,
        'balance': balance,
    })

@login_required
@transaction.atomic
def wallet_view(request):
    if request.method == 'POST':
        amount = request.POST.get('amount')
        tx_type = request.POST.get('transaction_type')
        
        if amount and float(amount) > 0 and tx_type in ['CREDIT', 'DEBIT']:
            Transaction.objects.create(
                user=request.user,
                amount=amount,
                transaction_type=tx_type,
            )
            return redirect('account')
            
    return render(request, 'wallet.html')

@login_required
def org_dashboard_view(request):
    org = request.user.groups.filter(name = "Organization").exists()
    if not org:
        raise PermissionDenied("Thou is an impostor among men")
    return render(request,"org_dash.html")

@login_required
@transaction.atomic
def create_event_view(request):
    if not request.user.groups.filter(name="Organization").exists():
        raise PermissionDenied("Thou is an impostor among men")
    if request.method == "POST":
        form = EventCreationForm(request.POST)
        formset = ScheduleFormSet(request.POST)

        if form.is_valid():
            event = form.save(commit=False)
            event.created_by = request.user

            if event.type == "SLOT":
                if formset.is_valid():
                    try:
                        event.save()
                        formset.instance = event
                        formset.save()
                        create_event_slots(event)
                        messages.success(request, f"Slot event '{event.name}' and its slots created successfully!")
                        return redirect('org_dashboard')
                    
                    except ValidationError:
                        event.delete()  
                        messages.error(request, f"Slot Generation Error")
                else:
                    messages.error(request, "Errors in schedule stubid.")
            
            else:
                event.save()
                messages.success(request, f"Ticket event '{event.name}' created successfully!")
                return redirect('org_dashboard')
    else:
        form = EventCreationForm()
        formset = ScheduleFormSet()

    return render(request, "create_event.html", {
        "form": form,
        "formset": formset
    })

@login_required
def events_view(request):
    events = Event.objects.filter(end_time__gt=timezone.now()).order_by("end_time")
    return render(request, "events.html", {"events": events,})

@login_required
def event_detail_view(request,event_id):
    event = get_object_or_404(Event, id=event_id)
    slot_dates = []
    selected_date = None
    slots = EventSlot.objects.none()
    
    if event.type == "SLOT":
        slot_dates = list(EventSlot.objects.filter(event = event,start_time__gt=timezone.now()).dates("start_time", "day"))
        requested_date = parse_date(request.GET.get("date", ""))
        if requested_date in slot_dates:
            selected_date = requested_date
        elif slot_dates:
            selected_date = slot_dates[0]

        if selected_date:
            slots = EventSlot.objects.filter(event=event,start_time__date=selected_date,start_time__gt=timezone.now()).order_by("start_time")

    return render(request, "event_detail.html", {
            "event": event,
            "slots":slots,
            "slot_dates": slot_dates,
            "selected_date": selected_date,
    })

@login_required
@transaction.atomic
def book_ticket_view(request, event_id):
    event = get_object_or_404(Event.objects.select_for_update(), id=event_id)
    
    if request.method != "POST":
        return redirect("event_detail", event_id=event.id)

    if event.type != "TICKET":
        messages.error(request, "This event does not support ticket bookings.")
        return redirect("event_detail", event_id=event.id)

    try:
        quantity = int(request.POST.get("quantity", 1))
    except (ValueError, TypeError):
        messages.error(request, "Invalid ticket quantity. Please enter a valid number.")
        return redirect("event_detail", event_id=event.id)

    if quantity <= 0:
        messages.error(request, "You must book at least 1 ticket.")
        return redirect("event_detail", event_id=event.id)

    if event.capacity is None or event.capacity <= 0:
        messages.error(request, "Sorry, this event is completely sold out or capacity is not configured.")
        return redirect("event_detail", event_id=event.id)

    if quantity > event.capacity:
        messages.error(
            request,
            f"Only {event.capacity} ticket(s) are available. You requested {quantity}."
        )
        return redirect("event_detail", event_id=event.id)

    total_amount = event.price * quantity

    User = get_user_model()
    user = User.objects.select_for_update().get(pk=request.user.pk)

    credits = Transaction.objects.filter(user=user, transaction_type="CREDIT").aggregate(total=Sum("amount"))["total"] or Decimal("0.00")
    debits = Transaction.objects.filter(user=user, transaction_type="DEBIT").aggregate(total=Sum("amount"))["total"] or Decimal("0.00")
    balance = credits - debits

    if balance < total_amount:
        messages.error(
            request,
            f"Insufficient balance. Your balance is ₹{balance} but you need ₹{total_amount}."
        )
        return redirect("event_detail", event_id=event.id)

    event.capacity -= quantity
    event.save(update_fields=["capacity"])

    booking = TicketBooking.objects.create(
        user=user,
        event=event,
        event_name=event.name,
        quantity=quantity,
        total_amount=total_amount,
        status="CONFIRMED"
    )

    Transaction.objects.create(
        user=user,
        amount=total_amount,
        transaction_type="DEBIT",
        created_at=timezone.now()
    )

    messages.success(request, f"Successfully booked {quantity} ticket(s) for {event.name}!")

    return render(request, "book_ticket.html", {
        "booking": booking,
        "event": event,
    })

@login_required
@transaction.atomic
def book_slot_view(request,event_id):
    event = get_object_or_404(Event.objects.select_for_update() , id = event_id)
    if request.method != "POST":
        messages.error(request, "Invalid request. Please try again.")
        return redirect("event_detail", event_id=event.id)

    if event.type != "SLOT":
        messages.error(request, "This event does not support slot bookings.")
        return redirect("event_detail", event_id=event.id)

    slot_id = request.POST.get("slot_id")
    if not slot_id:
        messages.error(request, "Please select a time slot.")
        return redirect("event_detail", event_id=event.id)
    
    slot = get_object_or_404(EventSlot.objects.select_for_update(), id=slot_id, event=event)

    if not slot.is_available:
        messages.error(request, "Sorry, this time slot has already been booked.")
        return redirect("event_detail", event_id=event.id)

    total_amount = event.price

    User = get_user_model()
    user = User.objects.select_for_update().get(id=request.user.id)

    credits = Transaction.objects.filter(user=user, transaction_type="CREDIT").aggregate(total=Sum("amount"))["total"] or Decimal("0.00")
    debits = Transaction.objects.filter(user=user, transaction_type="DEBIT").aggregate(total=Sum("amount"))["total"] or Decimal("0.00")
    balance = credits - debits

    if balance < total_amount:
        messages.error(
            request,
            f"Insufficient balance. Your balance is ₹{balance} but you need ₹{total_amount}."
        )
        return redirect("event_detail", event_id=event.id)

    slot.is_available = False
    slot.save(update_fields=["is_available"])

    booking = SlotBooking.objects.create(
        user=user,
        slot=slot,
        event_name=event.name,
        slot_start_time=slot.start_time,
        slot_end_time=slot.end_time,
        status="CONFIRMED"
    )

    Transaction.objects.create(
        user=user,
        amount=total_amount,
        transaction_type="DEBIT",
        created_at = timezone.now()
    )

    messages.success(request, f"Successfully booked slot for {event.name}!")
    
    return render(request, "book_slot.html", {
        "booking": booking,
        "event": event,
        "slot": slot,
        "total_amount" : total_amount
    })


@transaction.atomic
def confirm_ticket_view(request):
    if not request.user.groups.filter(name="Organization").exists():
        raise PermissionDenied("Thou is an impostor among men")
    event_query = request.GET.get('event_q', '').strip()
    selected_event_id = request.GET.get('event_id', '').strip()

    my_events = []
    selected_event = None
    ticket_bookings = []

    if event_query:
        my_events = Event.objects.filter(
            created_by=request.user,
            type="TICKET",
            name__icontains=event_query
        )
    else:
        my_events = Event.objects.filter(created_by=request.user, type="TICKET")

    if selected_event_id:
        selected_event = get_object_or_404(
            Event, id=selected_event_id, created_by=request.user, type="TICKET"
        )
        ticket_bookings = TicketBooking.objects.filter(event=selected_event).select_related('user')

    if request.method == "POST":
        booking_id = request.POST.get("booking_id")
        booking = get_object_or_404(
            TicketBooking, id=booking_id, event__created_by=request.user
        )
        booking.consumed = "YES"
        booking.save(update_fields=["consumed"])
        messages.success(request, f"Booking #{booking.id} ({booking.user.username}) consumed")

        return redirect(f"{request.path}?event_id={selected_event_id}&event_q={event_query}")

    return render(request, "confirm_tickets.html", {
        "event_query": event_query,
        "my_events": my_events,
        "selected_event": selected_event,
        "ticket_bookings": ticket_bookings,
    })

def analytics_view(request):
    if not request.user.groups.filter(name="Organization").exists():
        raise PermissionDenied("Thou is an impostor among men")
    events = Event.objects.filter(created_by = request.user)
    ticket_revenue = TicketBooking.objects.filter(event__created_by = request.user,event__type = "TICKET").aggregate(total = Sum('total_amount'))['total'] or 0
    slot_revenue = SlotBooking.objects.filter(slot__event__created_by = request.user,slot__event__type = "SLOT").aggregate(total = Sum('slot__event__price'))['total'] or 0 
    consumed_tickets = TicketBooking.objects.filter(consumed__iexact = "YES").aggregate(total = Sum('quantity'))['total'] or 0 
    total_tickets = TicketBooking.objects.all().aggregate(total = Sum('quantity'))['total'] or 0 
    return render(request,"analytics.html",{
        "ticket_revenue":ticket_revenue,
        "slot_revenue":slot_revenue,
        "consumed_tickets":consumed_tickets,
        "total_tickets" : total_tickets,
    })
    pass

def bookings_view(request):
    ticket_bookings = TicketBooking.objects.filter(user=request.user).select_related('event').order_by('-created_at')
    slot_bookings = SlotBooking.objects.filter(user=request.user).select_related('slot__event').order_by('-created_at')
    
    context = {
        'ticket_bookings': ticket_bookings,
        'slot_bookings': slot_bookings,
    }
    return render(request, "bookings.html", context)