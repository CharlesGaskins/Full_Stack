Part 1
Initial setup: Establish a Django project
1) Create a virtual enviroment
2) Install Django
3) Create project - django-admin startproject <project name>
Structure should look like this:
    <project name>  (The OUTER root directory is a container for your project)
        manage.py  (A command-line utility that lets you interact with this Django project in various ways.)
        <project name>/ (The INNER directory for your project. Its name is the Python package name you’ll need to use to import anything inside it (e.g. mysite.urls).)
            __init__.py  (An empty file that tells Python that this directory should be considered a Python package)
            settings.py  ( Settings/configuration for this Django project)
            urls.py  (The URL declarations for this Django project; a “table of contents” of your Django-powered site.)
            asgi.py  (An entry-point for ASGI-compatible web servers to serve your project)
            wsgi.py  (An entry-point for WSGI-compatible web servers to serve your project.)

4) Verify you are up and running by checking the server - python manage.py runserver
5) Create the actual app - python manage.py startapp <app name>
Structure should look like this:
    <app name>/
        __init__.py
        admin.py
        apps.py
        migrations/
            __init__.py
        models.py
        tests.py
        views.py
6) Write you're first view in <app name>/views.py
7) A: Create a URLconf in your app directory called urls.py
Structure should look like this now:
    <app name>/
        __init__.py
        admin.py
        apps.py
        migrations/
            __init__.py
        models.py
        tests.py
        urls.py <------ new
        views.py
  B:  See <app name>/urls.py for code
8) Go to project/urls.py ---> A: Point the root URLconf at the <app name>.urls module by inserting an include() in the urlpatterns list
                              B: Add an import for django.urls.include
9) Check your progress by running the server and checking localhost link + /<path you just made in step 9>


Part 2
Set up a database, create a model, and get introduced to automatically-generated admin site
This full stack project is using the already included SQLite db
-----DATABASE-----
10) Go to settings.py in project folder
11) Run python manage.py migrate in terminal ---> (this command looks at the INSTALLED_APPS in settings.py and creates
any necessary database tables according to the database settings in settings.py and the database migrations shipped with
the app)
-----CREATE MODEL-----
12) Go to <app name>/models.py
--->Create a class, class variable (which represents a database field in the model, Field Class (example: CharField (characters) or DateTimeField (datetime))
--->Name of each Field instance (what the columns of your db will be)
-----ACTIVATE MODEL-----
13) Referencing info in <app name>/apps.py, edit project/settings.py by adding '<app name>.apps.<app name>Config' to
INSTALLED_APPS
14) Run python manage.py makemigrations <app name> ---> this tells Django you made changes to your models
15) Check to see the SQL of each migration with python manage.py sqlmigrate <app name> <number under migration folder>
16) Run python manage.py migrate to make changes to your models official
-----CHECKING THE API-----
17) To check the API Django provides use python manage.py shell and explore the API
18) Add a __str__() method to your <app name>/models.py file just under each model
-----DJANGO ADMIN-----
19) First, run python manage.py createsuperuser ----> this creates a user that can login to the admin site
20) You will be prompted for a username, email and password
21) Check to see if everything is ok with python manage.py runserver and go to localhost link + /admin and login as the
administrator
22) If any of the models objects in <app name>/models.py allow for an admin interface:
----> open <app name>/admin.py and add
                from .models import <model object>
                admin.site.register(<model object>)
----> now that that particular model object has been registered, Django displays it on the admin index page


Part 3
CREATING MORE DYNAMIC VIEWS
23) Start by going back to <app name>/views.py and insert views that also contain an argument (if argument is needed)
24) Connect new views to <app name>/urls.py module by adding path() calls
25) This is where you could start working on the aesthetics of your url pages.In order to change the way the page looks,
you will need to alter the Python code.  Use Django's template system to separate the design from Python by creating a
template that the view can use
26) Create a template directory within your <app name> directory and then another directory within templates named after
your <app name> and then create an HTML file called index.html
Structure should look like this:
    <app name>/
        templates/
            <app name>/
                index.html
27) Update <app name>/views.py to be able to read the new index.html file
DEALING WITH A 404 ERROR
28) Include the Django shortcut get_object_or_404 function to deal with 404 issues and reformat the code in your
<app name>/views.py to deal with 404 issues if necessary
NAMESPACING URL NAMES
29) You may have multiple apps in a Django project, so in order to keep things organized and make sure that Django knows
how to differentiate between URL names, you should create a namespace in your URLconf
30) Go to <app name>/urls.py and add and app_name to set the application namespace and then update your html files
in the template folder

Part 4
WRITING A MINIMAL FORM
31) Create or update other view HTML pages in the template folder so that they contain and HTML <form> element
32) Update the URLconf in <app name>/urls.py where necessary to handle any changes to the update HTML
33) Update any place holder views in <app name>/views.py so that they actually function if haven't already
34) Again, if necessary create or update any HTML pages in the template folder associated with the updated views
UPDATE CODE TO USE GENERIC VIEWS (LESS CODE IS BETTER!!)
35) First, amend the URLconf in <app name>/urls.py
36) Amend <app name>/views.py by removing previously installed views and using Django's generic views instead where needed


Part 5
INCLUDE AUTOMATED TESTING
37) Go to <app name>/tests.py to write code for an automated test
38) Once test code has been written, run it with python manage.py test <app  name>
39) If there is a bug, fix it in the appropriate file
40) Run python manage.py test <app name> again
41) Test a view by using the Django test client in the shell


Part 6
CUSTOMIZATION AND LOOK OF APP
42) Add a new directory called "static" to your <app name> directory like you did with templates
43) Add a CSS stylesheet to the folder
44) Link the static file to your index.html


Part 7
CUSTOMIZE THE ADMIN FORM
45) Navigate to <app name>/admin.py

