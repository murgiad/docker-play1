FROM java:openjdk-8-jre

MAINTAINER Cristian Lucchesi <cristian.lucchesi@gmail.com>

RUN apt-get update && apt-get install -y sudo ant python && apt-get clean

ENV HOME /opt/play
RUN groupadd -r play -g 1000 && \
    useradd -u 1000 -r -g play -m -d $HOME -s /sbin/nologin -c "Play user" play

WORKDIR $HOME

USER play

RUN wget -q https://downloads.typesafe.com/play/1.4.1/play-1.4.1.zip && \
    unzip -q play-1.4.1.zip && rm play-1.4.1.zip && cd play-1.4.1

USER root
RUN ln -sf $HOME/play-1.4.1/play /usr/local/bin
USER play

EXPOSE 9000