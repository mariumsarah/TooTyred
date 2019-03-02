from django import forms
from django.utils.safestring import mark_safe
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm,UserChangeForm
from django.forms import ValidationError
from django.core.exceptions import ValidationError
from django.core.validators import EmailValidator
from django.core.validators import validate_email

class EditProfileForm(UserChangeForm):
    class Meta:
        model = User
        fields = (
        'first_name',
        'last_name',
        'email',
        'username')

    def clean(self):
        cleaned_data=super(EditProfileForm, self).clean()
        if 'email' not in cleaned_data:
            return cleaned_data

    def __init__(self, *args, **kwargs):
        super(UserChangeForm, self).__init__(*args, **kwargs)
        for field_name, field in self.fields.items():
            field.required = True
        del self.fields['password']

class RegistrationForm(UserCreationForm):
    email = forms.EmailField(validators=[validate_email]);
    termsofservice = forms.BooleanField(label=mark_safe('Agree to <a href="/home/termsandconditions/" target="_blank" style="color:white;"><u>Terms and Conditions</u></a>'));

    class Meta:
        model = User
        fields = [
        'first_name',
        'last_name',
        'email',
        'username',
        'password1',
        'password2',
        'termsofservice'
        ]

    def save(self, commit=True):
        user=super(RegistrationForm,self).save(commit=False)
        user.first_name = self.cleaned_data['first_name']
        user.last_name = self.cleaned_data['last_name']
        user.email = self.cleaned_data['email']
        user.username = self.cleaned_data['username']
        if commit:
            user.save()

        return user

#This code is used to validate the passwords are same and the email is not already registered
    def clean(self):
        cleaned_data=super(RegistrationForm, self).clean()
        if 'email' not in cleaned_data:
            return cleaned_data
        email = cleaned_data['email']
        try:
            match = User.objects.get(email=email)
        except User.DoesNotExist:
            return cleaned_data
        self.add_error('email','This email address is already registered.')
        return cleaned_data

#This code is used to make all fields as required
#https://django.cowhite.com/blog/django-form-validation-and-customization-adding-your-own-validation-rules/
    def __init__(self, *args, **kwargs):
        super(RegistrationForm, self).__init__(*args, **kwargs)
        for field_name, field in self.fields.items():
            field.required = True

class enquiryForm(forms.Form):
    firstname = forms.CharField();
    lastname = forms.CharField();
    email = forms.EmailField(validators=[validate_email])
    message = forms.CharField(widget=forms.Textarea)
