from django.db import models,transaction
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError
from django.utils import timezone
from datetime import datetime, timedelta

# Create your models here.
class TransactionType(models.TextChoices):
    CRE = ("CREDIT","Credit")
    DEB = ("DEBIT" , "Debit")

class Transaction(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='transactions')
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    transaction_type = models.CharField(
        max_length=10, 
        choices=TransactionType
    )
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user.username} - {self.transaction_type}: ₹{self.amount}"
