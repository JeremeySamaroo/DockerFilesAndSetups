FROM alpine:latest

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.34-r0/glibc-2.34-r0.apk
RUN apk --no-cache add --force-overwrite glibc-2.34-r0.apk
RUN apk add --force-overwrite alpine-baselayout-data

RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.34-r0/glibc-bin-2.34-r0.apk
RUN apk add glibc-bin-2.34-r0.apk

RUN apk upgrade --available
RUN apk add git
RUN echo git --version
RUN apk add curl
RUN echo curl --version
RUN apk add wget
RUN echo wget --version
RUN apk update
RUN apk search openssh
RUN apk add libxext libxrender libxtst libxi freetype procps gcompat libstdc++
RUN apk --update add --no-cache openssh bash \
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && echo "root:root" | chpasswd \
  && rm -rf /var/cache/apk/*RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN echo -n 'root:root' | chpasswd
EXPOSE 22
RUN mkdir -p /javaDevProjects
RUN mkdir -p /sshRunStart
COPY entrypoint.sh /sshRunStart/entrypoint.sh
RUN ["chmod", "+x", "/sshRunStart/entrypoint.sh"]

RUN mkdir -p /opt/java
COPY jdk-17.0.6_linux-aarch64_bin.tar.gz  /opt/java/jdk-17.0.6_linux-aarch64_bin.tar.gz

RUN tar -C /opt/java/ -xvf  /opt/java/jdk-17.0.6_linux-aarch64_bin.tar.gz
RUN rm  /opt/java/jdk-17.0.6_linux-aarch64_bin.tar.gz

ENV JAVA_HOME /opt/java/jdk-17.0.6
ENV PATH ${PATH}:${JAVA_HOME}/bin

RUN echo $JAVA_HOME&& \
    echo $PATH

ENTRYPOINT  /sshRunStart/entrypoint.sh; /bin/bash;