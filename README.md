# Ampliavision

# Setup
## Virtual env
<<<<<<< HEAD
Create a virtual environment by running the following commands in windows command promp directly from repository's root folder:
=======
Create a virtual environment by running the following commands in windows command promp directly from root folder:
>>>>>>> f46c4781518d43ba3975706b47ab4d521f62b30b
```sh
$ py -m venv .
$ "Scripts/activate.bat"
```
## Dependencies
```sh
$ pip install e .
```
## Database
<<<<<<< HEAD
Configure database connection arguments in the class named "connection" from the following route "src/Core/Constants.py".
=======
Configure database connection arguments in  the following route "src/Core/Constants.py", arguments will be configured in the class named "connection".
>>>>>>> f46c4781518d43ba3975706b47ab4d521f62b30b

Run sql scripts from Database folder.

## Run
```sh
$ set FLASK_APP=src
$ flask run
```



