FROM ubuntu:trusty
MAINTAINER "Syncano DevOps Team" <devops@syncano.com>

ENV LAST_REFRESHED 2016-03-22
ENV SYNCANO_APIROOT https://api.syncano.io/

RUN groupadd -r syncano && \
    useradd -u 1000 -r -g syncano syncano -d /tmp -s /bin/bash && \
    mkdir /home/syncano && \
    chown -R syncano /home/syncano

RUN chmod 1777 /tmp
#
ENV API_ROOT https://api.syncano.io
# make sure the package repository is up to date
# install python-software-properties (so you can do add-apt-repository)
RUN apt-get update && apt-get install -qqy \
    python-software-properties \
    software-properties-common

# add brightbox's repo, for ruby2.2
RUN apt-add-repository ppa:brightbox/ruby-ng
# install ruby2.2
RUN apt-get -y update && apt-get install -qqy \
    ruby2.2 \
    ruby2.2-dev \
    bundler \
    javascript-common

RUN gem install rest_client && \
    gem install syncano --pre

# create a special user to run code
# user without root privileges greatly improves security
USER syncano
WORKDIR /tmp
CMD "irb"
