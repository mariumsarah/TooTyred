---------------------INSTALLATIONS------------------------------------------
py -m pip install mysql
py -m pip install django-bootstrap3
----------------------------------------------------------------------------
Guide to run on localhost
----------------------------------------------------------------------------
1. Initialize database by importing tootyred.sql to phpAdmin
   or by copy pasting the content of tootyred.sql to the mySql Command line
2. Change the date after 'STARTS' in the file "tootyred update queries" to a
    time and date that is at 15,30,45 minute so if it is 13:04 am right now
     the time should be set to 13:15:00
3. Copy paste the content of "tootyred update queries" to the mySql Command line
4. In tooTyred->settings.py on line 45 change the password your root mySql
  localhost password
4. Use "py manage.py runserver" to run the django web application on localhost
5. The website will be fully functional at the time mentioned in 2
