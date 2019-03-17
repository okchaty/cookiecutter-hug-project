# -*- coding: utf-8 -*-
# !/usr/bin/env python
import os
from typing import List

from setuptools import find_packages, setup

requires: List[str] = []
dependencys: List[str] = []
with open(os.path.join(os.path.dirname(__file__), "requirements.txt")) as f:
    requires = f.read().splitlines()
    for key, require in enumerate(requires):
        if require.startswith(("git", "http")):
            dependencys.append(requires.pop(key))

setup(
    name="cookiecutter-hug-project",
    packages=find_packages(exclude=["tests"]),
    version="0.0.0",
    description="Cookiecutter template for hug",
    dependency_links=dependencys,
    author="Luis Mayta",
    author_email="slovacus@gmail.com",
    url="https://github.com/okchaty/cookiecutter-hug-project",
    keywords=["cookiecutter", "template", "hug"],
    install_requires=requires,
    tests_require=[
        "PyHamcrest==1.9.0",
        "pytest-cov",
        "pytest-flask",
        "pytest-mock==1.9.0",
        "pytest-runner",
    ],
    extras_require={
        "docs": ["mock", "sphinx>=1.7.2"],
        "tests": [
            "sphinx",
            "pytest>=3.7.2",
            "pytest-cache",
            "pytest-cov",
            "pytest-flakes",
            "pytest-pep8",
            "pytest-runner",
            "jinja2",
            "pygments",
        ],
    },
    classifiers=[
        "Development Status :: 4 - Beta",
        "Environment :: Console",
        "Intended Audience :: Developers",
        "Natural Language :: English",
        "License :: OSI Approved :: BSD License",
        "Programming Language :: Python",
        "Programming Language :: Python :: 2",
        "Programming Language :: Python :: 2.7",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.4",
        "Programming Language :: Python :: 3.5",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: Implementation :: CPython",
        "Programming Language :: Python :: Implementation :: PyPy",
        "Topic :: Software Development",
    ],
)
