##
## Java
##

ARG     REPO=""
ARG     DIST="debian"
ARG     VARIANT="bookworm-slim"
ARG     JAVA_VENDOR="openjdk"
ARG     JAVA_VERSION="17"
ARG     JAVA_VARIANT="jdk"
ARG     USERNAME=dev
ARG     USER_UID=1000
ARG     USER_GID=$USER_UID

FROM    ${REPO}${DIST}:${VARIANT}  AS buildenv

LABEL   org.opencontainers.image.title="java"
LABEL   org.opencontainers.image.version="1.2.0"
LABEL   org.opencontainers.image.authors="tak289 <50550259+tak289@users.noreply.github.com>"
LABEL   org.opencontainers.image.description="Dev and build environment for Java development."
LABEL   org.opencontainers.image.source=https://github.com/tak289/devenv
LABEL   org.opencontainers.image.licenses=MIT
LABEL   org.opencontainers.image.revision="${GITHUB_SHA}"

## Vars // emptied after FROM!
ARG     USERNAME
ARG     USER_UID
ARG     USER_GID
ARG     JAVA_VENDOR
ARG     JAVA_VERSION
ARG     JAVA_VARIANT

######## Build

ENV     DEBIAN_FRONTEND=noninteractive

## Update all packages
RUN     apt-get -q update --fix-missing && apt-get -qy upgrade

## System packages
RUN     apt-get -qy install --no-install-recommends \
        sudo \
        adduser \
        git \
        bash

## Java
RUN     apt-get -qy install --no-install-recommends \
        ${JAVA_VENDOR}-${JAVA_VERSION}-${JAVA_VARIANT} \
        maven

## Remove default system user
COPY    removesystemuser.sh /opt/removesystemuser.sh
RUN     /opt/removesystemuser.sh

## Setup non-root dev user
ENV     HOME /home/$USERNAME
RUN     groupadd --gid $USER_GID $USERNAME && \
        useradd --uid $USER_UID --gid $USER_GID --create-home --home-dir $HOME --shell /bin/bash $USERNAME
# Allow sudo
RUN     echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME

ENV     DEBIAN_FRONTEND=dialog
