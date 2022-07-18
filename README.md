# Installations 
py -m pip install mysql
py -m pip install django-bootstrap3

# Guide to run on localhost

1. Initialize database by importing localhostdemo.sql to phpAdmin
   or by copy pasting the content of localhostdemo.sql to the mySql Command line
2. Ctrl^F "STARTS" and change the date after 'STARTS' in the file to a
    time and date that is at 15,30,45 minute so if it is 13:04 am right now
     the time should be set to 13:15:00
3. In tooTyred->settings.py on line 45 change the password to your root mySql
  localhost password
4. Use "py manage.py runserver" to run the django web application on localhost
5. The website will be fully functional at the time mentioned in 2
