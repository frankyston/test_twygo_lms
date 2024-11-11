FROM ruby:3.3.5

ARG NODE_MAJOR_VERSION=22
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR_VERSION.x | bash -
RUN apt-get update -qq && \
    apt-get install -y build-essential libvips nodejs libpq-dev postgresql-client ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man && \
    npm install -g yarn

RUN mkdir /app
WORKDIR /app
ADD . /app
RUN gem install bundler -v 2.5.23
RUN bundle install
