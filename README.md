# Ampliavision

# Setup
## Virtual env
Create a virtual environment in the repository folder by running the following commands in windows command promp:
```sh
$ py -m venv .
$ "Scripts/activate.bat"
```
## Dependencies
```sh
$ pip install e .
```
## Database
Configure database connection arguments in "src/Core/Constants.py" in the class named connection.

Run sql scripts in Database folder.

## Run
```sh
$ set FLASK_APP=src
$ flask run
```



