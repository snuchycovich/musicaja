include .env
export $(shell sed 's/=.*//' .env)

DOCKER_NAME := ${PROJECT_NAME}
env ?= ${APP_ENV}

build:
	docker-compose -p $(DOCKER_NAME)-$(env) build

start:
	docker-compose -p $(DOCKER_NAME)-$(env) up -d --remove-orphans

stop:
	docker-compose -p $(DOCKER_NAME)-$(env) stop

exec-php:
	docker-compose -p $(DOCKER_NAME)-$(env) exec php /bin/bash

exec-db:
	docker-compose -p $(DOCKER_NAME)-$(env) exec database /bin/bash

logs:
	docker-compose -p $(DOCKER_NAME)-$(env) logs -f

clean:
	make stop
	docker rm $(shell sudo docker ps -a -q)

clean-full:
	docker rmi -f $(shell sudo docker images -q)

prune:	
	docker system prune