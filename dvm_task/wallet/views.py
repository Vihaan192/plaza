from decimal import Decimal, InvalidOperation
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.db.models import Sum
from django.db import transaction
from django.contrib import messages
from .models import Transaction, TransactionType


@login_required
def account_view(request):
    transactions = request.user.transactions.all().order_by('-created_at')
    credits = transactions.filter(transaction_type=TransactionType.CRE).aggregate(total=Sum('amount'))['total'] or Decimal("0.00")
    debits = transactions.filter(transaction_type=TransactionType.DEB).aggregate(total=Sum('amount'))['total'] or Decimal("0.00")
    balance = credits - debits

    return render(request, 'account.html', {
        'transactions': transactions,
        'balance': balance,
    })


@login_required
@transaction.atomic
def wallet_view(request):
    if request.method == 'POST':
        raw_amount = request.POST.get('amount', '').strip()
        try:
            amount = Decimal(raw_amount)
            if amount > 0 and amount == amount.to_integral_value():
                Transaction.objects.create(
                    user=request.user,
                    amount=amount,
                    transaction_type=TransactionType.CRE,
                )
                return redirect('account')
        except InvalidOperation:
            messages.error(request, "Please enter a valid whole-number amount.")

    return render(request, 'wallet.html')