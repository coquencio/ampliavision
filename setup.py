from setuptools import find_packages
from setuptools import setup

# File setup
setup(
    name="AmpliaVision",
    version="1.2.3",
    description="Api controllers for database administration",
    install_requires=["flask", "pymysql", "cryptography", "flask-cors", "secure-smtplib", "requests"],
)