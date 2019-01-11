from django import forms
class ExampleForm(forms.Form):
    field = forms.CharField(label='Message', max_length=80)

#class RegistrationForm(forms.ModelForm):
#    username=forms.CharField(label='Username:',max_length=15)
#    first_name=
#    last_name=
#    password1=
#    password2=
#    email=
#    termsofservice=
#    phonenumber=
