FROM alpine


RUN apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add --update coreutils && rm -rf /var/cache/apk/* \
	&& apk add --no-cache nss \
	&& rm -rf /var/cache/apk/*

RUN apk -e search git
RUN apk search git 
RUN apk add git
RUN apk --no-progress --purge --no-cache upgrade \
&& apk --no-progress --purge --no-cache add --upgrade \
    curl \
    wget \
    openssh \
&& apk --no-progress --purge --no-cache upgrade \
&& rm -vrf /var/cache/apk/* \
&& curl --version

# Install vanilla GLibC: https://github.com/sgerrand/alpine-pkg-glibc
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk
#RUN apk add glibc-2.35-r0.apk
RUN apk add alpine-baselayout=3.4.0-r0
RUN apk -U upgrade

RUN mkdir -p /opt/java

RUN curl -L --user "jeremeysamaroo.tt@gmail.com:Ab123456789@" https://download.oracle.com/java/17/archive/jdk-17_linux-aarch64_bin.tar.gz -o /opt/java/jdk-17_linux-aarch64_bin.tar.gz

RUN tar -C /opt/java -zxvf /opt/java/jdk-17_linux-aarch64_bin.tar.gz

RUN rm /opt/java/jdk-17_linux-aarch64_bin.tar.gz

RUN ln -s /opt/java/jdk-17 /opt/java/current

RUN touch /etc/profile.d/java.sh

#RUN echo -e "export JAVA_HOME=/opt/java/current\nexport PATH=$PATH:$JAVA_HOME/bin" >> /etc/
#profile.d/java.sh

ENV JAVA_HOME /opt/java/jdk-17
#ENV PATH $JAVA_HOME/bin:$PATH
ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN echo $JAVA_HOME && \
    echo $PATH

RUN which java

RUN apk add paxctl

RUN cd /opt/java/current/bin \
	&& paxctl -c java \
	&& paxctl -m java \
	&& paxctl -c javac \
	&& paxctl -m javac









