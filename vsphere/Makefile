all: pull push

.PHONY: pull push build


push:
	git add .
	git commit -m "Update."
	git push origin master

pull:
	git pull

build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o tf-cli