from django.urls import path
from .views import *

urlpatterns = [
    path('account/', account_view, name='account'),
    path('account/wallet', wallet_view, name='wallet'),
]