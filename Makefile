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

server-install:
	cd server && npm install

server-pm2-dev:
	cd server && pm2 reload ecosystem.config.js --only soul-connection-api-dev --env development

server-pm2-prod:
	cd server && pm2 reload ecosystem.config.js --only soul-connection-api-prod --env production

server:
	cd server && npm run dev

server-prod:
	cd server && npm run start

server-lint:
	cd server && npm run lint

server-lint-fix:
	cd server && npm run lintfix

server-test:
	cd server && npm run test

.PHONY: build clean run server
