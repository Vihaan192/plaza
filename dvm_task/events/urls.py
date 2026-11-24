from django.urls import path
from .views import *

urlpatterns = [
    path('', welcome_view, name='welcome'),
    path('home/', home_view, name='home'),
    path('org-dashboard/', org_dashboard_view, name='org_dashboard'),
    path('org-dashboard/create-event', create_event_view, name='create_event'),
    path("events/", events_view, name="events"),
    path("events/<int:event_id>/", event_detail_view, name="event_detail"),
]