from django.shortcuts import render,redirect,get_object_or_404
from django.contrib.auth.decorators import login_required
from django.core.exceptions import PermissionDenied
from django.db.models import Sum
from .models import *
from django.db import transaction
from django.utils.dateparse import parse_date
from django.utils import timezone
from django.contrib import messages
from django.contrib.auth import get_user_model
from decimal import Decimal
 
@login_required
def home_view(request):
    org =  request.user.groups.filter(name = "Organization").exists()
    events = Event.objects.filter(end_time__gt=timezone.now()).order_by("end_time")[:5]
    return render(request, 'home.html', {
        'org' :  org,
        'events': events,
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
def create_event_view(request):
    if not request.user.groups.filter(name="Organization").exists():
        raise PermissionDenied("Thou is an impostor among men")

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

    # Fix for sold out / None capacity bug causing 500 errors
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

    # Process Booking
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
    
    # Success renders the dedicated confirmation receipt page directly
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

    # 4. Mark Slot as Booked
    slot.is_available = False
    slot.save(update_fields=["is_available"])

    # 5. Create Slot Booking Record
    booking = SlotBooking.objects.create(
        user=user,
        slot=slot,
        event_name=event.name,
        slot_start_time=slot.start_time,
        slot_end_time=slot.end_time,
        status="CONFIRMED"
    )

    # 6. Deduct from User Ledger via Transaction
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

    