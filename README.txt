py -m pip install mysql
py -m pip install django-bootstrap3

-------------------MESSAGES TO GROUP MATES---------------------------------
IF YOU MAKE CHANGES TO THE SQL DATABASE MAKE SURE TO MIGRATE THEM
py manage.py makemigrations
py manage.py migrate
----------------------------------------------------------------------------
IF YOU MADE A SQL DATABASE AND YOU WANT TO MAKE THE MODEL FOR IT FOR MODELS.py
py manage.py inspectdb
----------------------------------------------------------------------------
IF THERE IS A PROBLEM WITH THE CSS file
try the following
1. Update cache on google chrome
2. py manage.py collectstatic
----------------------------------------------------------------------------
HERE IS HOW TO INITIALIZE DB AT DEPLOYMENT STAGE
COPY PASTE ALL FROM TOOTYRED.SQL
CHANGE DATETIME OF TOOTYRED UPDATE QUERIES TO NEXT 15 min INTERVAL
copy paste queries to MySQL
WAIT FOR 15 minutes
