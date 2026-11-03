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
    path('org-dashboard/create-event',create_event_view,name='create_event'),
    path('org-dashboard/confirm-tickets',confirm_ticket_view,name='confirm_tickets'),
    path('org-dashboard/analytics',analytics_view,name='analytics'),
    path("events/", events_view, name="events"),
    path("events/<int:event_id>/", event_detail_view, name="event_detail"),
    path("events/<int:event_id>/book_ticket/",book_ticket_view,name = "book_ticket"),
    path("events/<int:event_id>/book_slot/",book_slot_view,name = "book_slot"),
]