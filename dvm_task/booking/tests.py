from django.test import TestCase,TransactionTestCase,Client
from django.db import connections,connection
from threading import Thread
# Create your tests here.
from django.contrib.auth.models import User
from django.urls import reverse
from decimal import Decimal
from wallet.models import Transaction,TransactionType
from .models import *
from events.models import Event, EventType
from datetime import timedelta
from django.utils import timezone

# Create your tests here.
class RaceTest(TransactionTestCase):
    def setUp(self):
        self.user1 = User.objects.create_user(username='testuser1', password='password123')
        self.user2 = User.objects.create_user(username='testuser2', password='password1234')
        Transaction.objects.create(user=self.user1, amount=Decimal('1000.00'), transaction_type=TransactionType.CRE)
        Transaction.objects.create(user=self.user2, amount=Decimal('1000.00'), transaction_type=TransactionType.CRE)
        self.event = Event.objects.create(
            type=EventType.TIC,
            price=Decimal('500.00'),
            capacity=1,
            start_time= timezone.now() + timedelta(days=1),
            end_time= timezone.now() + timedelta(days=1, hours=2),
            duration=120,
            name='ConcertVIP',
            desc='Only one ticket available',
            location='PatelStatue',
            created_by=self.user1
        )

    def test_race(self):
        booking_url = reverse('book_ticket', args=[self.event.id])

        def attempt_booking(user):
            try:
                client = Client()
                client.force_login(user)
                client.post(booking_url, {'quantity': 1})

            except:
                pass
            connection.close()

        t1 = Thread(target=attempt_booking, args=(self.user1,))
        t2 = Thread(target=attempt_booking, args=(self.user2,))

        t1.start()
        t2.start()

        t1.join()
        t2.join()
        
        self.event.refresh_from_db() # update event capacity thingie from db

        confirmed_bookings = TicketBooking.objects.filter(
            event=self.event, status=StatusType.CON
        ).count()
        self.assertEqual(self.event.capacity, 0, "capacity wrong")
        self.assertEqual(confirmed_bookings, 1, "booking wrong")

