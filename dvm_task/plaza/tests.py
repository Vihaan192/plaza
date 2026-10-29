from django.test import TestCase

# Create your tests here.
from django.test import TestCase, Client
from django.contrib.auth.models import User
from django.urls import reverse
from plaza.models import Transaction

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