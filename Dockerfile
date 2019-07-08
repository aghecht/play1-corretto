FROM aghecht/corretto-8-ubuntu

RUN apt-get update && apt-get install -y sudo python unzip && apt-get clean

ARG version=1.3.4

WORKDIR /opt

RUN wget -q https://downloads.typesafe.com/play/$version/play-$version.zip && \
    unzip -q play-$version.zip && rm play-$version.zip

ENV HOME /opt/play-$version
RUN groupadd -r play -g 1000 && \
    useradd -u 1000 -r -g play -m -d $HOME -s /usr/sbin/nologin -c "Play user" play && \
    chown -R play $HOME && \
    ln -sf $HOME/play /usr/local/bin

USER play

EXPOSE 9000