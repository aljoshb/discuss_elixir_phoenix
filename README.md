# Discuss

To start the application locally, run the following commands in the root directory of the project (note that this assumes you have `postgreSQL` installed and running locally and that you have commented out the `post` field in `config/dev.ex` under the `Discuss.Repo` configs):

* Install the right version of phoenix: `mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new-1.2.5.ez`
* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.create && mix ecto.migrate`
* Install Node.js dependencies with `npm install`
* Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000/topics`](http://localhost:4000/topics) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Required config secrets

This application uses Github for OAuth authentication. Therefore, you will need to create an OAuth app corresponding to this application in your github account. Next, you will need to create a `config.secret.exs` file in the `config` directory that contains the `client_id` and `client_secret` of your Github OAuth app.

Your `config.secret.exs` file should contain the following, at the very least:

    use Mix.Config

    config :ueberauth, Ueberauth.Strategy.Github.OAuth,
      client_id: "<place your OAuth Github app client id here>",
      client_secret: "<place your OAuth Github app client secret here>"

## Database Server

This application makes use of `PostgreSQL`, make sure you have it installed.

## Running in Docker

There are two modes for running this application with Docker. The first involves creating and running the `postgres` database and the `phoenix` application individually. That is, with no `docker-compose` implying that the containers will be in seperate docker networks. The other mode involves using `docker-compose` to create and run both containers, therefore, each will be in different networks.

### Running without docker-compose

Since `docker-compose` is not being used, we have to build each image and run it's corresponding container separately.

The other in which the containers are run is important. The phoenix application depends on the `postgres` database, therefore, we need to first build the `postgres` image and run it's container first, before proceeding to do the same for the phoenix application.

Building and running the `postgres` database. Run these commands from the root directory of this project:

    docker build -t <preferred_postgres_image_name> -f Dockerfile-db .
    docker container run -p 5343:5432 --rm <preferred_postgres_image_name>

Notice that the `postgres` database is listening on port 5432 in it's local container but being forwarded any connection and requests to port 5343 (randomly chosen, because a `postgres` server is already listening on my mac by default) of the docker host (i.e. your machine).

Building and running the `phoenix` app. Run these commands from the root directory of this project:

    docker build -t <preferred_phoenix_image_name> .
    docker container run -p 4000:4000 --rm <preferred_phoenix_image_name>
