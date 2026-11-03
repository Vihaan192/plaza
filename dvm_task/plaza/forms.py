from django import forms
from django.forms.models import inlineformset_factory
from .models import Event, EventSchedule
from django.core.exceptions import ValidationError


class EventCreationForm(forms.ModelForm):
    class Meta:
        model = Event
        fields = ['name', 'type', 'price', 'capacity', 'duration', 'location', 'start_time', 'end_time', 'desc']
        widgets = {
            'desc': forms.Textarea(attrs={
                'rows': 4, 
                'placeholder': 'Provide details about your event...'
            }),
            'price':forms.NumberInput(attrs={'placeholder': 'e.g., Price in Rs'}),
            'start_time': forms.DateTimeInput(attrs={'type': 'datetime-local'}),
            'end_time': forms.DateTimeInput(attrs={'type': 'datetime-local'}),
            'duration': forms.NumberInput(attrs={'placeholder': 'in minutes, slot duration for slot , event duration for ticekt'}),
        }

    def clean(self):
        clean_data = super().clean()
        start_date = clean_data.get('start_time')
        end_date = clean_data.get('end_time')
        if(end_date <= start_date):
            raise ValidationError("End date earlier than start date")


ScheduleFormSet = inlineformset_factory(
    parent_model=Event,
    model=EventSchedule,
    fields=('date', 'start_time', 'end_time'),
    extra=1,        
    can_delete=True,  
    widgets={
        'date': forms.DateInput(attrs={'type': 'date'}),
        'start_time': forms.TimeInput(attrs={'type': 'time'}),
        'end_time': forms.TimeInput(attrs={'type': 'time'}),
        
    }
)