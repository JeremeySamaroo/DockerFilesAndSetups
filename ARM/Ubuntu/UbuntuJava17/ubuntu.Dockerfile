FROM ubuntu 

RUN apt-get update \
	&& apt-get upgrade -y

RUN apt install git -y
RUN git --version
RUN apt install curl -y
RUN echo curl --version

RUN mkdir -p /usr/lib/jvm

RUN curl -L --user "jeremeysamaroo.tt@gmail.com:Ab123456789@" https://download.oracle.com/java/17/archive/jdk-17_linux-aarch64_bin.tar.gz -o /usr/lib/jvm/jdk-17_linux-aarch64_bin.tar.gz

RUN tar -C /usr/lib/jvm -zxvf /usr/lib/jvm/jdk-17_linux-aarch64_bin.tar.gz

RUN rm /usr/lib/jvm/jdk-17_linux-aarch64_bin.tar.gz

RUN apt install nano -y 

ENV JAVA_HOME /usr/lib/jvm/jdk-17
#ENV PATH $JAVA_HOME/bin:$PATH
ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN echo $JAVA_HOME && \
    echo $PATH

#export PATH=$PATH: