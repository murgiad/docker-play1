### STAGE 1: Build ###
FROM debian:stretch-slim as builder

MAINTAINER Cristian Lucchesi <cristian.lucchesi@gmail.com>

ENV PLAY_VERSION 1.4.3

RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget -q https://downloads.typesafe.com/play/${PLAY_VERSION}/play-${PLAY_VERSION}.zip && \
    unzip -q play-${PLAY_VERSION}.zip

COPY play-${PLAY_VERSION}.jar /play-${PLAY_VERSION}/framework/

### STAGE 2: Setup ###

FROM openjdk:8-jdk-alpine

EXPOSE 9000
ENV PLAY_VERSION 1.4.3
ENV HOME /play
ENV PLAY_PATH $HOME/play-${PLAY_VERSION}

COPY --from=builder /play-${PLAY_VERSION} $PLAY_PATH

RUN apk --no-cache add python bash && \
    ln -sf $PLAY_PATH/play /usr/local/bin

WORKDIR $HOME