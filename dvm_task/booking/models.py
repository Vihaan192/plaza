from django.db import models
from django.contrib.auth.models import User
from events.models import Event, EventSlot


class ConsumedType(models.TextChoices):
    Y = ("YES", "Yes")
    N = ("NO", "No")


class StatusType(models.TextChoices):
    CON = ("CONFIRMED", "Confirmed")
    CAN = ("CANCELLED", "Cancelled")


class TicketBooking(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="ticket_users")
    event = models.ForeignKey(
        Event,
        on_delete=models.SET_NULL,
        null=True,
        related_name="ticket_events",
    )
    event_name = models.CharField(max_length=100, null=True, blank=True)
    quantity = models.PositiveIntegerField()
    total_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    status = models.CharField(max_length=10, choices=StatusType)
    created_at = models.DateTimeField(auto_now_add=True)
    consumed = models.CharField(max_length=10, choices=ConsumedType, default=ConsumedType.N)

    def __str__(self):
        return f"{self.user} : {self.event} : {self.status} "


class SlotBooking(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="slot_users")
    slot = models.ForeignKey(
        EventSlot,
        on_delete=models.SET_NULL,
        null=True,
        related_name="slot_events",
    )
    event_name = models.CharField(max_length=100, null=True, blank=True)
    slot_start_time = models.DateTimeField(null=True)
    slot_end_time = models.DateTimeField(null=True, blank=True)
    status = models.CharField(max_length=10, choices=StatusType)
    created_at = models.DateTimeField(auto_now_add=True)
    consumed = models.CharField(max_length=10, choices=ConsumedType, default=ConsumedType.N)

    def __str__(self):
        return f"{self.user} : {self.slot} : {self.status} "