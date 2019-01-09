from django.shortcuts import redirect
def welcome_redirect(request):
    return redirect('/home')
