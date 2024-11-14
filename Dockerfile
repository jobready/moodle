FROM ruby:2.3-slim

RUN apt-get update -y && apt-get install -y git

WORKDIR /app
ADD . .
RUN bundle install

# ENV MOODLE_URL=http://localhost:8888/moodle29/
# ENV MOODLE_TOKEN=87b95af2df709fa60b395b5c59a3fc2e
