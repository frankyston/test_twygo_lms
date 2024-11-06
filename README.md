## Setup of project

1. Create file `.env` and `env.test` off file `env.sample`.
2. Create network
```
docker network create -d bridge test_twygo_lms_network
```
3. Execute the command below for build image
```
docker compose up -d --no-deps --build app
```
4. Execute the command below for start project
```
docker compose up -d
or
./scripts/up.sh
```
5. Execute the command below for access bash
```
docker compose run --rm app bash
```
6. Execute the command below for create database
```
rails db:create
```
7. Execute the command below for migration database
```
rails db:migrate
```
8. Execute the command below for populate database
```
rails db:seed
```
9. Execute minitest
```
ENV_FILE=.env.test dcr -it --rm app bash
rake test
```
