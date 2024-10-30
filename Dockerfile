FROM jenkins/jenkins:lts

USER root

# Install Docker and RPM/DEB tools
RUN apt-get update && apt-get install -y \
    docker.io \
    rpm \
    dpkg-dev \
    build-essential \
    sudo

# Add Jenkins user to the Docker group
RUN usermod -aG docker jenkins

# Install plugins and restart Jenkins to apply them
RUN jenkins-plugin-cli --plugins "workflow-aggregator docker-workflow"

USER jenkins

