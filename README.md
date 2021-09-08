## Create a Rails App

```
 docker run -it --rm -v ${PWD}:/usr/src -w /usr/src ruby:2.6 sh -c 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt update -y \
&& apt install -y yarn nodejs \
&& gem install rails:"~> 6.0" \
&& rails new --skip-listen my-app'
```

## Change Ownership

In the project folder, run:

```
sudo chown $USER:$USER -R .
```

## Run the Rails App

```
docker run --rm -it -p 3000:3000 -v $PWD:/usr/src/app -w /usr/src/app ruby:2.6 sh -c 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt update -y \
&& apt install -y yarn nodejs \
&& bundle --without test production \
&& rails server -b 0.0.0.0'
```

## Create a Dockerfile

```
FROM ruby:2.6

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -y \
    && apt-get install -y nodejs yarn
ADD . /usr/src/app

WORKDIR /usr/src/app

RUN bundle install --without test production

CMD ["rails", "s", "-b", "0.0.0.0"]
```

## Create .dockerignore File

```
.git*
.git/**
db/*.sql*
log/*
tmp/**
Dockerfile
Readme
docker-compose.yml
config/master.key
```

## Build the Docker Image

```
docker build .
```

## Cache the Gemfile

```
docker run --rm -it -v ${PWD}:/app -w /app ruby:2.6 bundle lock
```

## Build the Image

```
docker build -t my-app:latest .
```

This runs bundle install again. Running the build again still runs bundle install again.

THIS IS NOT WORKING!



