FROM ruby:3.3

# Register Yarn package source.
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install additional packages.
RUN apt update -qq
RUN apt install -y nodejs yarn sqlite3 libsqlite3-dev

# Prepare working directory.
WORKDIR /opt/app
COPY ./app .
RUN gem install bundler
RUN gem install rails
RUN bundle install

EXPOSE 3000

# Start app server.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]