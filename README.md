# Maap Store

## Development environment

* Install Docker
* Start database & webserver:

```
$ docker-compose up
```

Open [http://localhost:3000](http://localhost:3000).

### Useful commands

```
# Open a terminal in the web server directory
$ docker-compose exec app bash

# Run linter and autofixes if needed
$ docker-compose exec app bundle exec rubocop -a

# Run tests
$ docker-compose exec app bundle exec rspec

```
