FROM ruby:2.6

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -y \
    && apt-get install -y nodejs yarn
ADD . /usr/src/app

WORKDIR /usr/src/app

RUN bundle install --without test production

CMD ["rails", "s", "-b", "0.0.0.0"]
