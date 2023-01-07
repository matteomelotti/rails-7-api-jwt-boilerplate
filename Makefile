help:
	@ echo 'setup build create_database install_gems start attach_web console_app console_db seed'

setup:
  docker-compose run web rails new . --api --force --database=postgresql --T

build:
	docker-compose build

install_gems:
	docker-compose run --rm web bundle install -j8

start:
	docker-compose up

startd:
	docker-compose up -d

stop:
	docker-compose stop

seed:
	docker-compose run --rm web rails db:seed

create_database:
	docker-compose run --rm web rake db:create

run_migrations:
	docker-compose run --rm web rake db:migrate

attach_web:
	docker attach sequra-backend-challenge-web-1

console_app:
	@ DB_CONTAINER_ID=$(shell docker ps -aqf "name=sequra-backend-challenge-web-1");  docker exec -it $$DB_CONTAINER_ID bash
console_db:
	@ DB_CONTAINER_ID=$(shell docker ps -aqf "name=sequra-backend-challenge-db-1");  docker exec -it $$DB_CONTAINER_ID bash

copy_dump:
	export DB_CONTAINER_ID="$$(docker inspect --format="{{.Id}}" sequra-backend-challenge-db-1)" && docker cp db/dump.sql.gz $$DB_CONTAINER_ID:/dump.sql.gz

import_database:
	export DB_CONTAINER_ID="$$(docker inspect --format="{{.Id}}" sequra-backend-challenge-db-1)" && docker exec -it $$DB_CONTAINER_ID bash -c "setup_database.sh"