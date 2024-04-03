##
## LaTeX
##

# FROM    debian:stable  AS buildenv
# FROM    ubuntu:jammy  AS buildenv
FROM    ubuntu:noble  AS buildenv

LABEL   version="1.0.0"
LABEL   description="Dev and build environment for LaTeX."
LABEL   com.example.vendor="tak289"
LABEL   org.opencontainers.image.authors="tak289"
LABEL   description="Dev and build environment for LaTeX."

## Vars
ARG     USERNAME=dev
ARG     USER_UID=1111
ARG     USER_GID=$USER_UID

######## Build

## Update all packages
RUN     apt-get -q update --fix-missing && apt-get -qy upgrade 

## System packages
RUN     apt-get -qy install --no-install-recommends \
        sudo \
        bash

## LaTeX
RUN     apt-get -qy install --no-install-recommends \
        texlive-full

## Setup non-root dev user
RUN     groupadd --gid $USER_GID $USERNAME && \
        useradd --uid $USER_UID --gid $USER_GID -m $USERNAME
# Allow sudo
RUN     echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME

## Switch to non-root
USER    $USERNAME
