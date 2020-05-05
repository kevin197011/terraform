all: pull push

.PHONY: pull push vsphere azure

pull:
	git pull

push:
	git add .
	git commit -m "Update."
	git push origin master

vsphere:
	cd vsphere/ && /usr/local/bin/terraform init
	cd vsphere/ && /usr/local/bin/terraform plan
	cd vsphere/ && /usr/local/bin/terraform apply --auto-approve

vsazurephere:
	cd azure/ && /usr/local/bin/terraform init
	cd azure/ && /usr/local/bin/terraform plan
	cd azure/ && /usr/local/bin/terraform apply --auto-approve
