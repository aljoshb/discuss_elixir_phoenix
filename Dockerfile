FROM elixir:1.8.1-alpine

WORKDIR /usr/src/app

COPY . .

# RUN apk add --update nodejs nodejs-npm
RUN apk add npm && \
    npm install

RUN apk add inotify-tools && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new-1.2.5.ez && \
    mix deps.get

RUN mix ecto.create && mix ecto.migrate
    
RUN mix compile

# ENV DATABASE_HOST host.docker.internal

# EXPOSE 4000

COPY . .

CMD ["mix", "phoenix.server"]
