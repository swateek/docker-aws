ARG BUILD_VERSION
ARG MAJOR_UBUNTU_VERSION="24.10"
ARG AWS_CLI_VERSION="2.17.30"

FROM ubuntu:${MAJOR_UBUNTU_VERSION} AS build-image
ARG BUILD_VERSION
ARG MAJOR_UBUNTU_VERSION
ARG AWS_CLI_VERSION
RUN apt-get -qq update
RUN apt install -qq -y curl unzip jq
RUN curl -sS -O 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64-'${AWS_CLI_VERSION}'.zip'
RUN unzip -qq awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip
RUN ./aws/install
RUN rm -rf aws awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip
RUN apt-get clean
