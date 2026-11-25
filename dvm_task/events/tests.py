from django.test import TestCase,TransactionTestCase,Client
from django.db import connections,connection
from threading import Thread
from django.core.exceptions import ValidationError
from django.contrib.auth.models import User
from django.urls import reverse
from decimal import Decimal
from events.models import Event,EventType
from datetime import timedelta
from booking.models import *
from django.db import transaction
from django.utils import timezone

class EventACID(TransactionTestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='admin_user', password='password123')

    def test_eventcreation(self):
        event_count_before = Event.objects.count()
        with self.assertRaises(ValidationError):
            event = Event.objects.create(
                type=EventType.SLO,
                price=Decimal('100.00'),
                capacity=10,
                start_time=timezone.now() + timedelta(days=2),
                end_time=timezone.now() + timedelta(days=1, hours=5),
                duration=60,
                name='Tennis',
                desc='Tennis court slots',
                location='Sports Complex',
                created_by=self.user
            )
        self.assertEqual(Event.objects.count(), event_count_before)

    def test_slotrollback(self):
        event_count_before = Event.objects.count()
        slot_count_before = EventSlot.objects.count()
        #dummy wrong event
        try:
            with transaction.atomic():
                event = Event.objects.create(
                    type=EventType.SLO,
                    price=Decimal('100.00'),
                    capacity=10,
                    start_time=timezone.now() + timedelta(days=1),
                    end_time=timezone.now() + timedelta(days=1, hours=5),
                    duration=60,
                    name='Corrupted Event',
                    desc='Should rollback',
                    location='Sports Complex',
                    created_by=self.user
                )
                for i in range(3):
                    if i == 2:
                        raise ValidationError("Slot generation failed")
                    EventSlot.objects.create(
                        event=event,
                        start_time=event.start_time + timedelta(minutes=i*60),
                        end_time=event.start_time + timedelta(minutes=(i+1)*60),
                    )
        except Exception as e:
            print(f"Error : {e}")

        self.assertEqual(Event.objects.count(), event_count_before)
        self.assertEqual(EventSlot.objects.count(), slot_count_before)