import re

from django.urls import reverse
from django.conf import settings
from django.shortcuts import redirect
from django.contrib.auth import logout
EXEMPT_URLS = [re.compile(settings.LOGIN_URL.lstrip('/'))]
if hasattr(settings, 'LOGIN_EXEMPT_URL'):
    EXEMPT_URLS += [re.compile(url) for url in settings.LOGIN_EXEMPT_URL]

LOGIN_EXEMPT_EMPLOYEE_URL = []
if hasattr(settings, 'LOGIN_EXEMPT_EMPLOYEE_URL'):
    LOGIN_EXEMPT_EMPLOYEE_URL += [re.compile(url) for url in settings.LOGIN_EXEMPT_EMPLOYEE_URL]
if hasattr(settings, 'LOGIN_EXEMPT_MANAGER_URL'):
    LOGIN_EXEMPT_EMPLOYEE_URL += [re.compile(url) for url in settings.LOGIN_EXEMPT_MANAGER_URL]

LOGIN_EXEMPT_USER_URL = []
if hasattr(settings, 'LOGIN_EXEMPT_USER_URL'):
    LOGIN_EXEMPT_USER_URL += [re.compile(url) for url in settings.LOGIN_EXEMPT_USER_URL]
if hasattr(settings, 'LOGIN_EXEMPT_MANAGER_URL'):
    LOGIN_EXEMPT_USER_URL += [re.compile(url) for url in settings.LOGIN_EXEMPT_MANAGER_URL]

LOGIN_EXEMPT_MANAGER_URL = []
if hasattr(settings, 'LOGIN_EXEMPT_USER_URL'):
    LOGIN_EXEMPT_MANAGER_URL += [re.compile(url) for url in settings.LOGIN_EXEMPT_EMPLOYEE_URL]
if hasattr(settings, 'LOGIN_EXEMPT_EMPLOYEE_URL'):
    LOGIN_EXEMPT_MANAGER_URL += [re.compile(url) for url in settings.LOGIN_EXEMPT_USER_URL]

class LoginRequiredMiddleware:

    def __init__(self,get_response):
        self.get_response = get_response

    def __call__(self,request):
        response = self.get_response(request)
        return response

    def process_view(self, request, view_func, view_args, view_kwargs):
        assert hasattr(request,'user')
        path = request.path_info.lstrip('/')
        print(path)
        #if not request.user.is_authenticated:
        #    if not any(url.match(path) for url in EXEMPT_URLS):
        #        return redirect(settings.LOGIN_URL)

        url_is_exempt=any(url.match(path) for url in EXEMPT_URLS)
        url_is_exempt_employee=any(url.match(path) for url in LOGIN_EXEMPT_EMPLOYEE_URL)
        url_is_exempt_user=any(url.match(path) for url in LOGIN_EXEMPT_USER_URL)
        url_is_exempt_man=any(url.match(path) for url in LOGIN_EXEMPT_MANAGER_URL)
        if path == reverse('home:logout').lstrip('/'):
            logout(request)
        print(LOGIN_EXEMPT_USER_URL)
        print(url_is_exempt_user)
        if request.user.is_authenticated and url_is_exempt:
            if request.user.is_staff and not request.user.is_superuser:
                return redirect(settings.LOGIN_REDIRECT_EMP_URL)
            elif request.user.is_staff and request.user.is_superuser:
                return redirect(settings.LOGIN_REDIRECT_MAN_URL)
            else:
                return redirect(settings.LOGIN_REDIRECT_URL)
        elif request.user.is_authenticated or url_is_exempt:
            if request.user.is_staff and not request.user.is_superuser and url_is_exempt_employee:
                return redirect(settings.LOGIN_REDIRECT_EMP_URL)
            if request.user.is_staff and request.user.is_superuser and url_is_exempt_man:
                return redirect(settings.LOGIN_REDIRECT_MAN_URL)
            elif not request.user.is_staff and url_is_exempt_user:
                return redirect(settings.LOGIN_REDIRECT_URL)
            return None
        else:
            return redirect(settings.LOGOUT_REDIRECT_URL)
