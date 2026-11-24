from .models import *

def is_org(request):
    org = request.user.groups.filter(name = "Organization").exists()
    return {
        'org':org,
    }