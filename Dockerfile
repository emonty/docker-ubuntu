FROM ubuntu:trusty
MAINTAINER Monty Taylor <mordred@inaugust.com>
COPY build.sh /build.sh
RUN bash /build.sh
