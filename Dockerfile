FROM elixir:1.8.1-alpine

EXPOSE 4000

WORKDIR /usr/src/app

COPY . .

# RUN apk add --update nodejs nodejs-npm
RUN apk add npm

RUN npm install

RUN apk add inotify-tools

RUN mix local.hex --force

RUN mix local.rebar --force

RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new-1.2.5.ez

RUN mix deps.get

RUN mix compile

ENV DATABASE_HOST host.docker.internal

CMD ["mix", "phoenix.server"]
