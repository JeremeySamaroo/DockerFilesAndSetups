FROM ubuntu 

RUN apt-get update \
	&& apt-get upgrade -y

RUN apt install git -y
RUN git --version
RUN apt install curl -y
RUN echo curl --version
RUN apt install wget -y
RUN echo wget --version


RUN mkdir -p /usr/lib/jvm

COPY jdk-11.0.17_linux-aarch64_bin.tar /usr/lib/jvm/jdk-11.0.17_linux-aarch64_bin.tar

COPY apache-maven-3.6.3-bin.tar.gz /usr/lib/apache-maven-3.6.3-bin.tar.gz

RUN tar -C /usr/lib/jvm -xvf /usr/lib/jvm/jdk-11.0.17_linux-aarch64_bin.tar

RUN rm /usr/lib/jvm/jdk-11.0.17_linux-aarch64_bin.tar

RUN tar -C /usr/lib/ -xvf /usr/lib/apache-maven-3.6.3-bin.tar.gz

RUN rm /usr/lib/apache-maven-3.6.3-bin.tar.gz

RUN apt install nano -y 

ENV JAVA_HOME /usr/lib/jvm/jdk-11.0.17
ENV PATH ${PATH}:${JAVA_HOME}/bin

ENV M2_HOME /usr/lib/apache-maven-3.6.3
ENV PATH ${PATH}:${M2_HOME}/bin


RUN echo $JAVA_HOME && \
	echo $M2_HOME && \
    echo $PATH

RUN apt install nodejs -y
RUN apt install npm -y

RUN mkdir -p /app
