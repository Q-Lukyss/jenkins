FROM jenkins/jenkins:2.492.1-jdk17

USER root

# Installation des dépendances et de docker-ce-cli
RUN apt-get update && apt-get install -y lsb-release curl \
    && curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
         https://download.docker.com/linux/debian/gpg \
    && echo "deb [arch=$(dpkg --print-architecture) \
         signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
         https://download.docker.com/linux/debian \
         $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update && apt-get install -y docker-ce-cli

# Crée le groupe docker (s'il n'existe pas) et ajoute l'utilisateur jenkins au groupe docker
RUN groupadd -f -r docker && usermod -aG docker jenkins

USER jenkins

RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
