FROM ruby:2.6

ARG uid
ARG username="chronicles"
ARG workdir="/chronicles"

ENV BUNDLE_PATH="$workdir/.gems"

RUN adduser -u "$uid" "$username"
USER "$username"
WORKDIR "$workdir"

CMD bash
