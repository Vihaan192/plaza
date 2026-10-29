from django.db import models,transaction
from django.contrib.auth.models import User
from datetime import timedelta
from django.core.exceptions import ValidationError
from django.utils import timezone
from datetime import datetime, timedelta

# Create your models here.
class Transaction(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='transactions')
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    transaction_type = models.CharField(
        max_length=10, 
        choices=[('CREDIT', 'Credit'), ('DEBIT', 'Debit')]
    )
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.transaction_type}: ₹{self.amount}"

class Event(models.Model):
    type = models.CharField(
        max_length = 10,
        choices = [('SLOT','Slot'),('TICKET','Ticket')]
    )
    capacity = models.PositiveIntegerField(null = True, blank = True, help_text = "Max capacity for ticket based events")
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    duration = models.PositiveIntegerField(help_text="Duration of slots for slot based events / total duration for ticket based in minutes")
    name = models.CharField(max_length = 50)
    desc = models.TextField()
    location = models.CharField(max_length = 100)
    created_by = models.ForeignKey(User,on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    def __str__(self):
        return self.name

class EventSlot(models.Model):
    event = models.ForeignKey(Event, on_delete = models.CASCADE , related_name = "slots")
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    is_available = models.BooleanField(default=True)

    def __str__(self):
        return f"{self.event.name} - {self.start_time}"


def validate_slots(start_time, end_time, step):
    if step <= 0:
        raise ValidationError("Slot duration must be greater than zero.")

    if end_time <= start_time:
        raise ValidationError("End time must be after start time.")

    duration_seconds = (end_time - start_time).total_seconds()
    slot_seconds = step * 60
    if duration_seconds % slot_seconds != 0:
        raise ValidationError("Schedule duration must be divisible by the slot duration.")


@transaction.atomic
def create_event_slots(event):
    if event.type != "SLOT":
        return

    if event.duration <= 0:
        raise ValidationError("Slot duration must be greater than zero.")

    slots = []

    for schedule in event.schedules.all():
        if schedule.end_time <= schedule.start_time:
            raise ValidationError(f"Closing time must be after opening time on {schedule.date}.")

        start = datetime.combine(schedule.date, schedule.start_time)
        end = datetime.combine(schedule.date, schedule.end_time)
        start = timezone.make_aware(start, timezone.get_current_timezone())
        end = timezone.make_aware(end, timezone.get_current_timezone())

        if (end - start).total_seconds() % (event.duration * 60) != 0:
            raise ValidationError(f"Hours on {schedule.date} must divide evenly into slots.")

        current = start
        while current < end:
            slot_end = current + timedelta(minutes=event.duration)
            slots.append(EventSlot(event=event,start_time=current,end_time=slot_end))
            current = slot_end

    EventSlot.objects.bulk_create(slots)
    return slots

class EventSchedule(models.Model):
    event = models.ForeignKey(Event,on_delete=models.CASCADE,related_name="schedules")
    date = models.DateField()
    start_time = models.TimeField()
    end_time = models.TimeField()

    def __str__(self):
        return f"{self.event.name} - {self.date}"