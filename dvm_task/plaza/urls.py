from django.urls import path
from django.contrib.auth import views as auth_views
from plaza.views import *

urlpatterns = [
    path('login/', auth_views.LoginView.as_view(template_name='login.html'), name='login'),
    path('logout/', auth_views.LogoutView.as_view(next_page='login'), name='logout'),
    path('home/',home_view , name = 'home'),
    path('account/',account_view , name = 'account'),
    path('account/wallet', wallet_view , name = 'wallet'),
    path('org-dashboard/',org_dashboard_view,name='org_dashboard'),
]