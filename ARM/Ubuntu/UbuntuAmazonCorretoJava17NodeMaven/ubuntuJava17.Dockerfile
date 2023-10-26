FROM ubuntu 

RUN apt-get update \
	&& apt-get upgrade -y

RUN apt install git -y
RUN git --version
RUN apt install curl -y
RUN echo curl --version
RUN apt install wget -y
RUN echo wget --version
RUN apt -y install systemctl
RUN apt -y install ufw
RUN apt install openssh-client -y

RUN apt update && apt install openssh-server sudo -y
RUN  echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN service ssh start
EXPOSE 22

RUN mkdir -p /usr/lib/jvm

COPY amazon-corretto-17.0.7.7.1-linux-aarch64.tar.gz /usr/lib/jvm/amazon-corretto-17.0.7.7.1-linux-aarch64.tar.gz

COPY apache-maven-3.6.3-bin.tar.gz /usr/lib/apache-maven-3.6.3-bin.tar.gz

RUN tar -C /usr/lib/jvm -xvf /usr/lib/jvm/amazon-corretto-17.0.7.7.1-linux-aarch64.tar.gz

RUN rm /usr/lib/jvm/amazon-corretto-17.0.7.7.1-linux-aarch64.tar.gz

RUN tar -C /usr/lib/ -xvf /usr/lib/apache-maven-3.6.3-bin.tar.gz

RUN rm /usr/lib/apache-maven-3.6.3-bin.tar.gz

RUN apt install nano -y

# Downloading gcloud package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

ENV JAVA_HOME /usr/lib/jvm/amazon-corretto-17.0.7.7.1-linux-aarch64
ENV PATH ${PATH}:${JAVA_HOME}/bin

ENV M2_HOME /usr/lib/apache-maven-3.6.3
ENV PATH ${PATH}:${M2_HOME}/bin


RUN echo $JAVA_HOME && \
	echo $M2_HOME && \
    echo $PATH

RUN apt-get update \
	&& apt-get upgrade -y

RUN apt install nodejs -y
RUN apt-get install npm -y



RUN mkdir -p /app

RUN mkdir -p /sshRunStart

COPY runStartupSSHService.sh /sshRunStart/runStartupSSHService.sh

RUN ["chmod", "+x", "/sshRunStart/runStartupSSHService.sh"]

ENTRYPOINT /sshRunStart/runStartupSSHService.sh; /bin/bash;