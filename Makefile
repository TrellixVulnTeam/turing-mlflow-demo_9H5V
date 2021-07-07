DOCKERPORT1=5000
HOSTPORT1=5000
DOCKERPORT2=1234
HOSTPORT2=1234
DOCKERPORT3=8080
HOSTPORT3=8080
VERSION=0.0.1
CONTAINER=jannetta/mlflow
NAME=mlflow
DOCKERFILE=Dockerfile
VOLUME=mlflow
HOSTMOUNTPOINT=/home/jannetta/DOCKERVOLUMES/MLFlow/models
DOCKERMOUNTPOINT=/models


echo:
	echo $(DOCKERFILE)
build:
	docker build --force-rm -f $(DOCKERFILE) -t $(CONTAINER):$(VERSION) .

run:
	docker run -d -p $(HOSTPORT1):$(DOCKERPORT1) -p $(HOSTPORT2):$(DOCKERPORT2) -p $(HOSTPORT3):$(DOCKERPORT3) --name $(NAME) -v $(HOSTMOUNTPOINT):$(DOCKERMOUNTPOINT) $(CONTAINER):$(VERSION) 

stop:
	docker stop $(NAME)

start:
	docker start $(NAME)

exec:
	docker exec -ti $(NAME) bash

tar:
	docker save -o $(NAME)$(VERSION).tar $(CONTAINER):$(VERSION)

install:
	docker load -i $(NAME)$(VERSION).tar

push:
	git push --atomic origin master $(VERSION)

network:
	docker network create --gateway 172.16.1.1 --subnet 172.16.1.0/24 mvc_network

remove:
	docker stop $(NAME)
	docker rm $(NAME)
