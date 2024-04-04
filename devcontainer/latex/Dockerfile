##
## LaTeX
##

ARG     DIST="ubuntu"
ARG     VARIANT="noble"

FROM    ${DIST}:${VARIANT}  AS buildenv

LABEL   version="1.1.1"
LABEL   description="Dev and build environment for LaTeX."
LABEL   com.example.vendor="tak289"
LABEL   org.opencontainers.image.authors="tak289"
LABEL   description="Dev and build environment for LaTeX."

## Vars
ARG     USERNAME=dev
ARG     USER_UID=1000
ARG     USER_GID=$USER_UID

######## Build

ENV DEBIAN_FRONTEND=noninteractive

## Update all packages
RUN     apt-get -q update --fix-missing && apt-get -qy upgrade 

## System packages
RUN     apt-get -qy install --no-install-recommends \
        sudo \
        git \
        bash

## LaTeX
RUN     apt-get -qy install --no-install-recommends \
        texlive-full

## Additional applications
RUN     apt-get -qy install --no-install-recommends \
        gnuplot \
        gnuplot-nox \
        make

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

ENV DEBIAN_FRONTEND=dialog
