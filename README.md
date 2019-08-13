[![Build Status](https://travis-ci.org/instedd/maap-store.svg?branch=master)](https://travis-ci.org/instedd/maap-store)

# Maap Store

## Development environment

* Install Docker
* Start database & webserver:

```
$ docker-compose up
```
* Run seeds:

```
$ docker-compose run --rm app bundle exec rails db:seed
```

Open [http://localhost:3000/admin](http://localhost:3000/admin)

### Useful commands

```
# Open a terminal in the web server directory
$ docker-compose run app bash

# Run linter and autofixes if needed
$ docker-compose run app bundle exec rubocop -a

# Run tests
$ docker-compose run --rm app bundle exec rspec

# Run seeds
$ docker-compose run --rm app bundle exec rails db:seed
```
