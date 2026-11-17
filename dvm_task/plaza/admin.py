from django.contrib import admin,messages
from django.contrib.auth.models import User
from django.contrib.auth.admin import UserAdmin
from .models import *

admin.site.unregister(User)

@admin.register(User)
class CustomUserAdmin(UserAdmin):
    list_display = ('username', 'email', 'first_name', 'last_name', 'is_org')

    def is_org(self, obj):
        return obj.groups.filter(name='Organization').exists()
    
    is_org.boolean = True
    is_org.short_description = 'Organization Member'

class EventScheduleInline(admin.TabularInline):
    model = EventSchedule
    extra = 1

class EventAdmin(admin.ModelAdmin):
    inlines = [EventScheduleInline]

    list_display = ('name', 'type', 'price', 'capacity', 'start_time','end_time','location', 'created_by')
    list_filter = ('type', 'start_time', 'location')
    search_fields = ('name', 'desc', 'location')

class EventSlotAdmin(admin.ModelAdmin):
    list_display = ('event', 'start_time', 'end_time', 'is_booked') if hasattr(EventSlot, 'is_booked') else ('event', 'start_time', 'end_time')
    list_filter = ('event', 'start_time')
    search_fields = ('event__name',)


admin.site.register(Event, EventAdmin)
admin.site.register(EventSlot, EventSlotAdmin)