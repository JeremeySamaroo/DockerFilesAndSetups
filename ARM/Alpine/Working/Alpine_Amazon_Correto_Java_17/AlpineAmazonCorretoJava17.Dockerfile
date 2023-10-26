FROM alpine:latest

RUN apk add curl
RUN echo curl --version
RUN apk add wget
RUN echo wget --version

Run apk --no-cache add ca-certificates wget
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk
RUN apk add --force-overwrite glibc-2.28-r0.apk

RUN apk update
RUN apk  upgrade



RUN apk add git
RUN apk --no-cache add curl
RUN apk add --update --no-cache openssh-server
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/AuthorizedKeysFile      .ssh/authorized_keys /#AuthorizedKeysFile      .ssh/authorized_keys /' /etc/ssh/sshd_config
RUN echo -n 'root:root' | chpasswd
RUN apk add openrc
RUN rc-update add sshd

EXPOSE 22

COPY runStartupSSHService.sh /

RUN ["chmod", "+x", "runStartupSSHService.sh"]

RUN mkdir -p /opt/java

COPY amazon-corretto-17.0.8.8.1-alpine-linux-aarch64.tar.gz /opt/java/amazon-corretto-17.0.8.8.1-alpine-linux-aarch64.tar.gz

RUN tar -C /opt/java/ -xvf /opt/java/amazon-corretto-17.0.8.8.1-alpine-linux-aarch64.tar.gz

RUN rm /opt/java/amazon-corretto-17.0.8.8.1-alpine-linux-aarch64.tar.gz

COPY java.sh /etc/profile.d/java.sh

RUN echo sh /etc/profile.d/java.sh

RUN ["chmod", "+x", "/opt/java/amazon-corretto-17.0.8.8.1-alpine-linux-aarch64"]

RUN ["chmod", "700", "/opt/java/amazon-corretto-17.0.8.8.1-alpine-linux-aarch64"]

RUN apk add attr
RUN apk add paxctl

RUN  cd /opt/java/amazon-corretto-17.0.8.8.1-alpine-linux-aarch64/bin && paxctl -c java
RUN cd /opt/java/amazon-corretto-17.0.8.8.1-alpine-linux-aarch64/bin && paxctl -m java

RUN echo paxctl -c javac
RUN echo paxctl -m javac

ENV JAVA_HOME /opt/java/amazon-corretto-17.0.8.8.1-alpine-linux-aarch64
ENV PATH ${PATH}:${JAVA_HOME}/bin

ENTRYPOINT /runStartupSSHService.sh; /bin/ash;


