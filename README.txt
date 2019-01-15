1. go to tooTyred/settings.py and change the password in DATABASES to your mysql password
2. go to sql and type this
6. source C:/Users/sarah/Desktop/tooTyred/tootyred.sql;(change it to your filepath, make sure its front slash)
7. I created a superuser with username tootyredsuperuser and password tootyred so use it if you want to log in
make sure you are able to log in
tootyredsuperuser
tootyredsuperuser@superuser.com
Password:tootyred
mmm12345

8. py manage.py runserver should work

THINGS YOU NEED TO HAVE DOWNLOADED:
MYSQL
PYTHON
py -m pip install mysql (if this doesnot work then download visual studio and python x64)
py -m pip install django-bootstrap3
----------------------------------------------------------------------------
TO TEST THE FORGOT PASSWORD FEATURE:
1. OPEN GIT CMD AT THE SAME TIME AS py manage.py runserver is RUNNING
2. TYPE THIS IN py -m smtpd -n -c DebuggingServer localhost:1025
3. GO TO FORGOT PASSWORD AND ENTER EMAIL
4. YOU WILL SEE THE EMAIL ON GIT CMD COPY THE LINK AND PASTE IT ON BROWSER
----------------------------------------------------------------------------
HOW TO EXPORT DATABASE TO tootyred.sql go to MYSQL WORKBENCH and on the left bottom corner
click on the database then select data export in management and export all tables to .sql file path
----------------------------------------------------------------------------
IF YOU MAKE CHANGES TO THE SQL DATABASE MAKE SURE TO MIGRATE THEM
py manage.py makemigrations
py manage.py migrate
----------------------------------------------------------------------------
IF YOU MADE A SQL DATABASE AND YOU WANT TO MAKE THE MODEL FOR IT FOR MODELS.py
py manage.py inspectdb
----------------------------------------------------------------------------
IF THERE IS A PROBLEM WITH THE CSS file
py manage.py collectstatic --noinput --clear
----------------------------------------------------------------------------
