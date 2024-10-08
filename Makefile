install:
	pip install --upgrade pip &&\
	pip install -r requirements.txt

test:
	python -m pytest -vv --cov=main test_*.py
	py.test --nbval *.ipynb

format:	
	black *.py 

lint:
	#disable comment to test speed
	#pylint --disable=R,C --ignore-patterns=test_.*?py *.py mylib/*.py
	#ruff linting is 10-100X faster than pylint
	ruff check *.py mylib/*.py

container-lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

refactor: format lint

generate_and_push:
	python main.py
	git config --global user.name "Jiaxin-Cindy"
	git config --global user.email "jiaxin.gao1997@gmail.com"
	git add .
	git commit -m "test" || true
	git push

all: install lint test format deploy

