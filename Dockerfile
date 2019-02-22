FROM elixir:1.8.1-alpine

WORKDIR /usr/src/app

COPY . .

RUN apk add npm && \
    npm install

RUN apk add inotify-tools && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new-1.2.5.ez && \
    mix deps.get
    
RUN mix compile

ENV DATABASE_URL host.docker.internal

ENV DATABASE_PASSWORD postgres

ENV DATABASE_USER postgres

CMD ["mix", "do", "ecto.create,", "ecto.migrate,", "phoenix.server"]
