from django.test import TestCase,TransactionTestCase,Client
from django.db import connections,connection
from threading import Thread
# Create your tests here.
from django.contrib.auth.models import User
from django.urls import reverse
from decimal import Decimal
from plaza.models import *


'''
class WalletTransactionTest(TestCase):
    def setUp(self):
        self.client = Client()
        self.user = User.objects.create_user(username='testuser', password='password123')
        self.url = reverse('wallet')

    def test_cannot_create_negative_transaction(self):
        self.client.login(username='testuser', password='password123')

        response = self.client.post(self.url, {
            'amount': '-100.00',
            'transaction_type': 'CREDIT'
        })

        self.assertEqual(Transaction.objects.filter(user=self.user).count(), 0)
        
class RaceTest(TransactionTestCase):
    def setUp(self):
        self.user1 = User.objects.create_user(username='testuser1', password='password123')
        self.user2 = User.objects.create_user(username='testuser2', password='password1234')
        Transaction.objects.create(user=self.user1, amount=Decimal('1000.00'), transaction_type='CREDIT')
        Transaction.objects.create(user=self.user2, amount=Decimal('1000.00'), transaction_type='CREDIT')
        self.event = Event.objects.create(
            type='TICKET',
            price=Decimal('500.00'),
            capacity=1,
            start_time=timezone.now() + timedelta(days=1),
            end_time=timezone.now() + timedelta(days=1, hours=2),
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
            event=self.event, status='CONFIRMED'
        ).count()
        self.assertEqual(self.event.capacity, 0, "capacity wrong")
        self.assertEqual(confirmed_bookings, 1, "booking wrong")

class EventACID(TransactionTestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='admin_user', password='password123')

    def test_eventcreation(self):
        event_count_before = Event.objects.count()
        with self.assertRaises(ValidationError):
            event = Event.objects.create(
                type='SLOT',
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
                    type='SLOT',
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

'''