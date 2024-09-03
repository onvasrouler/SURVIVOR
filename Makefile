##
## EPITECH PROJECT, 2024
## MAKEFILE
## File description:
## Makefile that compiles soul connection
##

all: build

build:
	cd client && flutter build

clean:
	cd client && flutter clean

run:
	cd client && flutter run

server:
	cd server && nodemon

.PHONY: build clean run server
