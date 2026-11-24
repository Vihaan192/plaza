from django.urls import path
from .views import *

urlpatterns = [
    path('org-dashboard/confirm-tickets', confirm_ticket_view, name='confirm_tickets'),
    path('org-dashboard/analytics', analytics_view, name='analytics'),
    path("events/<int:event_id>/book_ticket/", book_ticket_view, name="book_ticket"),
    path("events/<int:event_id>/book_slot/", book_slot_view, name="book_slot"),
    path("home/bookings", bookings_view, name='booking'),
    path("bookings/ticket/<int:booking_id>/confirmation/", ticket_confirmation_view, name="ticket_confirmation"),
    path("bookings/slot/<int:booking_id>/confirmation/", slot_confirmation_view, name="slot_confirmation"),
]