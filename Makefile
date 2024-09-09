##
## EPITECH PROJECT, 2024
## SURVIVOR
## File description:
## Makefile
##

all: build

build:
	cd client && flutter build

clean:
	cd client && flutter clean

run:
	cd client && flutter run -d chrome --web-browser-flag --disable-web-security

server:
	cd server && npm run dev

server-prod:
	cd server && npm run start

server-lint:
	cd server && npm run lint 

scrapper:
	cd server && nodemon scrapper.py

scrapper-prod:
	cd server && python3 scrapper.py

scrapper-lint:
	cd server && pylint scrapper.py

server-lint-fix:
	cd server && npm run lintfix

serveur-test:
	cd server && npm run test

.PHONY: build clean run server
