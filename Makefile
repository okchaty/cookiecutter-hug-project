#
# See ./CONTRIBUTING.rst
#

OS := $(shell uname)
.PHONY: help build up requirements clean lint test help
.DEFAULT_GOAL := help

PROJECT := cookiecutter-hug-project

PYTHON_VERSION=3.6.4
PYENV_NAME="${PROJECT}"

# Configuration.
SHELL := /bin/bash
ROOT_DIR=$(shell pwd)
MESSAGE_HAPPY:="Done! ${MESSAGE} Now Happy Coding"
SOURCE_DIR:=$(ROOT_DIR)/
SOURCE_DIR=$(ROOT_DIR)/
REQUIREMENTS_DIR=$(ROOT_DIR)/requirements
PROVISION_DIR:=$(ROOT_DIR)/provision
FILE_README:=$(ROOT_DIR)/README.rst
PATH_DOCKER_COMPOSE:=provision/docker-compose
DOCKER_SERVICE=app

pip_install := pip install -r
docker-compose:=docker-compose -f docker-compose.yml

include extras/make/*.mk

help:
	@echo '${MESSAGE} Makefile for ${PROJECT}'
	@echo ''
	@echo 'Usage:'
	@echo '    environment               create environment with pyenv'
	@echo '    clean                     remove files of build'
	@echo '    setup                     install requirements'
	@echo ''
	@make alias.help
	@make docker.help
	@make docs.help
	@make test.help

clean:
	@rm -rf .tox *.egg *.egg-info dist build .coverage .eggs .mypy_cache
	@rm -rf docs/build
	@find . -name '__pycache__' -delete -print -o -name '*.pyc' -delete -print -o -name '*.pyo' -delete -print -o -name '*~' -delete -print -o -name '*.tmp' -delete -print
	@echo

setup: clean
	@echo "=====> Install package dependences in ${PYENV_NAME}..."
	$(pip_install) "${REQUIREMENTS_DIR}/setup.txt"
	pre-commit install
	cp -rf .hooks/prepare-commit-msg .git/hooks/
	@if [ ! -e ".env" ]; then \
		cp -rf .env-sample .env;\
	fi

environment: clean
	@echo "=====> loading virtualenv ${PYENV_NAME}..."
	@pyenv virtualenv ${PYTHON_VERSION} ${PYENV_NAME} >> /dev/null 2>&1; \
	@pyenv activate ${PYENV_NAME} >> /dev/null 2>&1 || echo $(MESSAGE_HAPPY)
