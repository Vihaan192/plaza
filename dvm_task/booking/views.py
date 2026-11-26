from decimal import Decimal
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.core.exceptions import PermissionDenied
from django.db.models import Sum
from django.db import transaction
from django.utils import timezone
from django.contrib import messages
from django.contrib.auth import get_user_model
from events.models import Event, EventSlot, EventType
from wallet.models import Transaction, TransactionType
from .models import *


@login_required
@transaction.atomic
def book_ticket_view(request, event_id):
    event = get_object_or_404(Event.objects.select_for_update(), id=event_id)

    if request.method != "POST":
        return redirect("event_detail", event_id=event.id)

    if event.type != EventType.TIC:
        messages.error(request, "This event does not support non ticket bookings.")
        return redirect("event_detail", event_id=event.id)

    try:
        quantity = int(request.POST.get("quantity", 1))
    except (ValueError, TypeError):
        messages.error(request, "Invalid ticket quantity. Enter valid no.")
        return redirect("event_detail", event_id=event.id)

    if quantity <= 0:
        messages.error(request, "You must book at least 1 ticket.")
        return redirect("event_detail", event_id=event.id)

    if event.capacity is None or event.capacity <= 0:
        messages.error(request, "Sorry, event unavailable.")
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

    credits = Transaction.objects.filter(
        user=user, transaction_type=TransactionType.CRE
    ).aggregate(total=Sum("amount"))["total"] or Decimal("0.00")
    debits = Transaction.objects.filter(
        user=user, transaction_type=TransactionType.DEB
    ).aggregate(total=Sum("amount"))["total"] or Decimal("0.00")
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
        status=StatusType.CON,
    )

    Transaction.objects.create(
        user=user,
        amount=total_amount,
        transaction_type=TransactionType.DEB,
        created_at=timezone.now(),
    )

    return redirect("ticket_confirmation", booking_id=booking.id)


@login_required
def ticket_confirmation_view(request, booking_id):
    booking = get_object_or_404(TicketBooking, id=booking_id, user=request.user)
    return render(request, "book_ticket.html", {"booking": booking})


@login_required
@transaction.atomic
def book_slot_view(request, event_id):
    event = get_object_or_404(Event.objects.select_for_update(), id=event_id)

    if request.method != "POST":
        messages.error(request, "Invalid request. Please try again.")
        return redirect("event_detail", event_id=event.id)

    if event.type != EventType.SLO:
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

    credits = Transaction.objects.filter(
        user=user, transaction_type=TransactionType.CRE
    ).aggregate(total=Sum("amount"))["total"] or Decimal("0.00")
    debits = Transaction.objects.filter(
        user=user, transaction_type=TransactionType.DEB
    ).aggregate(total=Sum("amount"))["total"] or Decimal("0.00")
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
        status=StatusType.CON,
    )

    Transaction.objects.create(
        user=user,
        amount=total_amount,
        transaction_type=TransactionType.DEB,
        created_at=timezone.now(),
    )

    return redirect("slot_confirmation", booking_id=booking.id)


@login_required
def slot_confirmation_view(request, booking_id):
    booking = get_object_or_404(
        SlotBooking.objects.select_related("slot__event"),
        id=booking_id,
        user=request.user,
    )
    slot = booking.slot
    event = slot.event if slot else None
    return render(request, "book_slot.html", {
        "booking": booking,
        "event": event,
        "slot": slot,
        "total_amount": event.price if event else None,
    })


@transaction.atomic
@login_required
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
            type=EventType.TIC,
            name__icontains=event_query,
        )
    else:
        my_events = Event.objects.filter(created_by=request.user, type=EventType.TIC)

    if selected_event_id:
        selected_event = get_object_or_404(
            Event, id=selected_event_id, created_by=request.user, type=EventType.TIC
        )
        ticket_bookings = TicketBooking.objects.filter(
            event=selected_event
        ).select_related('user')

    if request.method == "POST":
        booking_id = request.POST.get("booking_id")
        booking = get_object_or_404(
            TicketBooking.objects.select_for_update(), id=booking_id, event__created_by=request.user
        )
        if booking.consumed == ConsumedType.Y:
            messages.error(request,"ALready consumed")
        else:
            booking.consumed = ConsumedType.Y
            booking.save(update_fields=["consumed"])
            messages.success(request, f"Booking #{booking.id} ({booking.user.username}) consumed")
        return redirect(f"{request.path}?event_id={selected_event_id}&event_q={event_query}")

    return render(request, "confirm_tickets.html", {
        "event_query": event_query,
        "my_events": my_events,
        "selected_event": selected_event,
        "ticket_bookings": ticket_bookings,
    })


@login_required
def analytics_view(request):
    if not request.user.groups.filter(name="Organization").exists():
        raise PermissionDenied("Thou is an impostor among men")

    ticket_revenue = TicketBooking.objects.filter(
        event__created_by=request.user,
        event__type=EventType.TIC,
    ).aggregate(total=Sum('total_amount'))['total'] or Decimal("0.00")

    slot_revenue = SlotBooking.objects.filter(
        slot__event__created_by=request.user,
        slot__event__type=EventType.SLO,
    ).aggregate(total=Sum('slot__event__price'))['total'] or Decimal("0.00")

    consumed_tickets = TicketBooking.objects.filter(
        event__created_by=request.user,
        consumed=ConsumedType.Y,
    ).aggregate(total=Sum('quantity'))['total'] or 0

    total_tickets = TicketBooking.objects.filter(
        event__created_by=request.user,
    ).aggregate(total=Sum('quantity'))['total'] or 0

    return render(request, "analytics.html", {
        "ticket_revenue": ticket_revenue,
        "slot_revenue": slot_revenue,
        "consumed_tickets": consumed_tickets,
        "total_tickets": total_tickets,
    })


@login_required
def bookings_view(request):
    ticket_bookings = TicketBooking.objects.filter(
        user=request.user
    ).select_related('event').order_by('-created_at')
    slot_bookings = SlotBooking.objects.filter(
        user=request.user
    ).select_related('slot__event').order_by('-created_at') 

    context = {
        'ticket_bookings': ticket_bookings,
        'slot_bookings': slot_bookings,
    }
    return render(request, "bookings.html", context)