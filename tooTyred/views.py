from django.shortcuts import redirect

def welcome_redirect(request):
    return redirect('/home')

def login_success(request):
    if request.user.is_staff and not request.user.is_superuser:
        return redirect('/operator/log/')
    elif request.user.is_staff and request.user.is_superuser:
        return redirect('/manager/log/')
    else:
        return redirect('/home/reserve/')
