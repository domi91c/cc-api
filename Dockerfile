FROM ruby:2.6.3-alpine

RUN apk update && apk add build-base nodejs postgresql-dev tzdata

RUN mkdir /var/www
WORKDIR /var/www

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install

COPY . .

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "8080"]

