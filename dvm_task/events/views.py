from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.core.exceptions import PermissionDenied, ValidationError
from django.db import transaction
from django.utils.dateparse import parse_date
from django.utils import timezone
from django.contrib import messages
from booking.models import TicketBooking
from .models import Event, EventSlot, EventType, create_event_slots
from .forms import EventCreationForm, ScheduleFormSet


def welcome_view(request):
    return render(request, 'welcome.html')


@login_required
def home_view(request):
    org = request.user.groups.filter(name="Organization").exists()
    events = Event.objects.filter(end_time__gt=timezone.now()).order_by("end_time")[:5]
    latest_bookings = TicketBooking.objects.filter(
        user=request.user
    ).select_related('event').order_by('-id')[:5]
    return render(request, 'home.html', {
        #'org': org,
        'events': events,
        'latest_bookings': latest_bookings,
    })


@login_required
def org_dashboard_view(request):
    org = request.user.groups.filter(name="Organization").exists()
    if not org:
        raise PermissionDenied("Thou is an impostor among men")
    return render(request, "org_dash.html")


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

            if event.type == EventType.SLO:
                if formset.is_valid():
                    try:
                        event.save()
                        formset.instance = event
                        formset.save()
                        create_event_slots(event)
                        messages.success(
                            request,
                            f"Slot event '{event.name}' and its slots created successfully"
                        )
                        return redirect('org_dashboard')
                    except ValidationError:
                        event.delete()
                        messages.error(request, "Slot Generation Error")
                else:
                    messages.error(request, "Errors in schedule.")
            else:
                event.save()
                messages.success(
                    request,
                    f"Ticket event '{event.name}' created successfully!"
                )
                return redirect('org_dashboard')
    else:
        form = EventCreationForm()
        formset = ScheduleFormSet()

    return render(request, "create_event.html", {
        "form": form,
        "formset": formset,
    })


@login_required
def events_view(request):
    events = Event.objects.filter(end_time__gt=timezone.now()).order_by("end_time")
    return render(request, "events.html", {"events": events})


@login_required
def event_detail_view(request, event_id):
    event = get_object_or_404(Event, id=event_id)
    slot_dates = []
    selected_date = None
    slots = EventSlot.objects.none()

    if event.type == EventType.SLO:
        slot_dates = list(
            EventSlot.objects.filter(
                event=event,
                start_time__gt=timezone.now(),
            ).dates("start_time", "day")
        )
        raw_date = request.GET.get("date", "")
        try:
            requested_date = parse_date(raw_date)
        except ValueError:
            requested_date = None

        if requested_date in slot_dates:
            selected_date = requested_date
        elif slot_dates:
            selected_date = slot_dates[0]

        if selected_date:
            slots = EventSlot.objects.filter(
                event=event,
                start_time__date=selected_date,
                start_time__gt=timezone.now(),
            ).order_by("start_time")

    return render(request, "event_detail.html", {
        "event": event,
        "slots": slots,
        "slot_dates": slot_dates,
        "selected_date": selected_date,
    })