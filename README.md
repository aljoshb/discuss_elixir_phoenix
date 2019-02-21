# Discuss

To start the Phoenix app:

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

Currently, the phoenix application can be run in a docker container, while the postgresql server is still running on local host (i.e. docker host). However, to connect from the phoenix application in the docker container to the postgres database running locally, the phoenix app has to connect to it via the private ip address of the docker host. To do this without having to find the specific value of the private address, connect to the special docker DNS name, `host.docker.internal`, which will then correctly resolve the private ip address of the docker host. This has already been set up in `config/dev.exs` and `Dockerfile`.

Run the following commands from the root directory.

To build the docker image:

    docker build -t <preferred_image_name> .

To run the container:

    docker container run -p 4000:4000 --rm <preferred_image_name>
