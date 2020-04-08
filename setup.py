from setuptools import find_packages
from setuptools import setup


setup(
    name="AmpliaVision",
    version="1.0.0",
    description="Api controllers for database administration",
    install_requires=["flask", "pymysql", "cryptography"],
)