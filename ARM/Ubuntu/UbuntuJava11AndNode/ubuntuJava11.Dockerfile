FROM ubuntu 

RUN apt-get update \
	&& apt-get upgrade -y

RUN apt install git -y
RUN git --version
RUN apt install curl -y
RUN echo curl --version

RUN mkdir -p /usr/lib/jvm

COPY jdk-11.0.17_linux-aarch64_bin.tar /usr/lib/jvm/jdk-11.0.17_linux-aarch64_bin.tar

RUN tar -C /usr/lib/jvm -xvf /usr/lib/jvm/jdk-11.0.17_linux-aarch64_bin.tar

RUN rm /usr/lib/jvm/jdk-11.0.17_linux-aarch64_bin.tar

RUN apt install nano -y 

ENV JAVA_HOME /usr/lib/jvm/jdk-11.0.17
ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN echo $JAVA_HOME && \
    echo $PATH

RUN apt install nodejs -y
RUN apt install npm -y

RUN mkdir -p /app
