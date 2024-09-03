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
	cd client && flutter run

server:
	cd server && npm run dev

server-prod:
	cd server && npm run start

server-lint:
	cd server && npm run lint 

.PHONY: build clean run server
