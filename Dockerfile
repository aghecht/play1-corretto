FROM aghecht/amazon-corretto-8

RUN apt-get update && apt-get install -y sudo ant python unzip && apt-get clean

ENV HOME /opt/play
RUN groupadd -r play -g 1000 && \
    useradd -u 1000 -r -g play -m -d $HOME -s /usr/sbin/nologin -c "Play user" play
    
WORKDIR $HOME

USER play

ARG version=1.3.4

RUN wget -q https://downloads.typesafe.com/play/$version/play-$version.zip && \
    unzip -q play-$version.zip && rm play-$version.zip

USER root
RUN ln -sf $HOME/play-$version/play /usr/local/bin
USER play

EXPOSE 9000