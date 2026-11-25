from django.test import TestCase,TransactionTestCase,Client
from django.db import connections,connection
from threading import Thread
from django.contrib.auth.models import User
from django.urls import reverse
from decimal import Decimal
from .models import *

# Create your tests here.
class WalletTransactionTest(TestCase):
    def setUp(self):
        self.client = Client()
        self.user = User.objects.create_user(username='testuser', password='password123')
        self.url = reverse('wallet')

    def test_cannot_create_negative_transaction(self):
        self.client.login(username='testuser', password='password123')

        response = self.client.post(self.url, {
            'amount': '-100.00',
            'transaction_type': TransactionType.CRE
        })

        self.assertEqual(Transaction.objects.filter(user=self.user).count(), 0)