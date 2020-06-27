# Ampliavision

# Setup
## Virtual env
Create a virtual environment by running the following commands in windows command promp directly from repository's root folder:

```sh
$ py -m venv .
$ "Scripts/activate.bat"
```
## Dependencies
```sh
$ pip install e .
```
## Database
Configure database connection arguments in the file from the following route "src/Core/connectionsConstants.py".

Run sql scripts from Database folder.

## Run
```sh
$ set FLASK_APP=src
$ flask run
```



