FROM jenkins/jenkins:lts

USER root

# Install Docker CLI + Docker Compose plugin so Jenkins can run docker compose
# against the host's Docker daemon (mounted as /var/run/docker.sock).
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg \
        git \
        lsb-release \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg \
        | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
    && chmod a+r /etc/apt/keyrings/docker.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
        https://download.docker.com/linux/debian $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
        > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends docker-ce-cli docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

# Pre-install required Jenkins plugins so the pipeline works out of the box.
RUN jenkins-plugin-cli --plugins \
        git \
        workflow-aggregator \
        pipeline-stage-view \
        configuration-as-code

# Skip the initial setup wizard - we manage config via JCasC and pre-baked job XML.
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc.yaml

# Bake the pre-configured admin user and pipeline job into the image's
# reference directory. Jenkins copies these to /var/jenkins_home/ on first boot.
COPY casc/jenkins.yaml /var/jenkins_home/casc.yaml
COPY jobs/ /usr/share/jenkins/ref/jobs/

# Run as root so we can access the bind-mounted /var/run/docker.sock.
USER root
