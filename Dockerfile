FROM ruby:2.6.3-alpine

RUN apk update && apk add build-base nodejs postgresql-dev tzdata

# create a folder /myapp in the docker container and go into that folder
RUN mkdir /project
WORKDIR /project

# Copy the Gemfile and Gemfile.lock from app root directory into the /myapp/ folder in the docker container
COPY Gemfile /project/Gemfile
COPY Gemfile.lock /project/Gemfile.lock

# Run bundle install to install gems inside the gemfile
RUN gem install bundler:2.1.4
RUN bundle install

# Copy the whole app
COPY . /project
