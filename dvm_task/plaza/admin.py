from django.contrib import admin
from django.contrib.auth.models import User
from django.contrib.auth.admin import UserAdmin
from .models import *


class EventScheduleInline(admin.TabularInline):
    model = EventSchedule
    extra = 1
    

class EventAdmin(admin.ModelAdmin):
    inlines = [EventScheduleInline]
    def save_related(self, request, form, formsets, change):
        super().save_related(request, form, formsets, change)

        if not change:
            create_event_slots(form.instance)


admin.site.register(Event, EventAdmin)
admin.site.register(EventSlot)