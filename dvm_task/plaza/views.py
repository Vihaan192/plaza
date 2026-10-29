from django.shortcuts import render,redirect
from django.contrib.auth.decorators import login_required
from django.core.exceptions import PermissionDenied
from django.db.models import Sum
from .models import *

@login_required
def home_view(request):
    org =  request.user.groups.filter(name = "Organization").exists()
    events = Event.objects.all().order_by("start_time")
    return render(request, 'home.html', {
        'org' :  org,
        'events': events,
    })

@login_required
def account_view(request):
    transactions = request.user.transactions.all().order_by('-created_at') # leading - sorts by descending orderr
    credits = transactions.filter(transaction_type='CREDIT').aggregate(Sum('amount'))['amount__sum'] or 0
    debits = transactions.filter(transaction_type='DEBIT').aggregate(Sum('amount'))['amount__sum'] or 0
    balance = credits - debits

    return render(request, 'account.html', {
        'transactions': transactions,
        'balance': balance,
    })

@login_required
def wallet_view(request):
    if request.method == 'POST':
        amount = request.POST.get('amount')
        tx_type = request.POST.get('transaction_type')
        
        if amount and float(amount) > 0 and tx_type in ['CREDIT', 'DEBIT']:
            Transaction.objects.create(
                user=request.user,
                amount=amount,
                transaction_type=tx_type,
            )
            return redirect('account')
            
    return render(request, 'wallet.html')

@login_required
def org_dashboard_view(request):
    org = request.user.groups.filter(name = "Organization").exists()
    if not org:
        raise PermissionDenied("Thou is an impostor among men")
    return render(request,"org_dash.html")

@login_required
def create_event_view(request):
    if not request.user.groups.filter(name="OrganizationMembers").exists():
        raise PermissionDenied
