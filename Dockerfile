FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
apt-get -y install apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get install docker-ce-cli

#RUN apt-get install -y docker-ce

RUN groupadd docker && usermod -a -G docker jenkins && newgrp docker

#USER jenkins

#While running the container I had to mount the /var/run/docker.sock to be able to share the
#docker daemon with host machine and I just had to install the docker CLI in the jenkins container.
