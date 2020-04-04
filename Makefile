SRC = $(wildcard ./*.ipynb)

POETRY=poetry
POETRY_RUN=$(POETRY) run

BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
HASH := $(shell git rev-parse HEAD)
TAG := $(shell git tag -l --contains HEAD)

all: handy_dict docs

handy_dict: $(SRC)
	$(POETRY_RUN) nbdev_build_lib
	touch handy_dict

docs_serve: docs
	cd docs && bundle exec jekyll serve

docs: $(SRC)
	$(POETRY_RUN) nbdev_build_docs
	touch docs

test:
	$(POETRY_RUN) nbdev_test_nbs

release: pypi
	$(POETRY_RUN) nbdev_bump_version

pypi: dist
	$(POETRY_RUN) twine upload --repository pypi dist/*

dist: clean
	$(POETRY_RUN) python setup.py sdist bdist_wheel

clean:
	rm -rf dist

check_on_master:
ifeq ($(BRANCH),master)
	echo "You are good to go!"
else
	$(error You are not in the master branch)
endif

release: check_on_master
	$(POETRY_RUN) bumpversion pre --verbose
	git push --follow-tags

patch: check_on_master
	$(POETRY_RUN) bumpversion patch --verbose
	git push --follow-tags

minor: check_on_master
	$(POETRY_RUN) bumpversion minor --verbose
	git push --follow-tags

major: check_on_master
	$(POETRY_RUN) bumpversion major --verbose
	git push --follow-tags

publish:
ifeq ($(TAG),)
	@echo "Skipping PyPi publishing"
else
	twine upload --skip-existing --repository pypi dist/*
endif