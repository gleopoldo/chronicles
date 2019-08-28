FROM ruby:2.6

ARG uid
ARG username="chronicles"
ARG workdir="/chronicles"

RUN adduser -u "$uid" "$username"
USER "$username"
WORKDIR "$workdir"

CMD bash
