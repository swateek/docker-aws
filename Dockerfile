ARG BUILD_VERSION
ARG MAJOR_UBUNTU_VERSION="24.04"
ARG AWS_CLI_VERSION="2.17.30"
ARG SESSION_MANAGER_PLUGIN_VERSION="1.2.677.0"

FROM ubuntu:${MAJOR_UBUNTU_VERSION} AS build-image
ARG BUILD_VERSION
ARG MAJOR_UBUNTU_VERSION
ARG AWS_CLI_VERSION
ARG SESSION_MANAGER_PLUGIN_VERSION

RUN apt-get -qq update
RUN apt install -qq -y curl unzip jq openssh-client
RUN curl -sS -O 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64-'${AWS_CLI_VERSION}'.zip'
RUN unzip -qq awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip
RUN ./aws/install
RUN rm -rf aws awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip

RUN curl -sS 'https://s3.amazonaws.com/session-manager-downloads/plugin/'${SESSION_MANAGER_PLUGIN_VERSION}'/ubuntu_64bit/session-manager-plugin.deb' -o 'session-manager-plugin.deb'
RUN dpkg -i session-manager-plugin.deb
RUN rm session-manager-plugin.deb

RUN apt-get clean
