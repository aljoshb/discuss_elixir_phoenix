# Discuss

To start your Phoenix app:

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
