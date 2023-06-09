# Created By Enrique Plata

SHELL = /bin/bash

.DEFAULT_GOAL := help

.PHONY: setup
setup: ## 		0.- Setup environment
	@ conda env create -f conda_env.yml

help:
	@ echo "Please use \`make <target>' where <target> is one of"
	@ perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}'
