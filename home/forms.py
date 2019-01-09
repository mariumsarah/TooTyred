from django import forms

class ExampleForm(forms.Form):
    field = forms.CharField(label='Message', max_length=80)
