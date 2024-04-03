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
ARG     WORKSPACE="/workspace"

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

# ## Setup non-root dev user
# ENV     HOME /home/$USERNAME
# RUN     groupadd --gid $USER_GID $USERNAME && \
#         useradd --uid $USER_UID --gid $USER_GID --create-home --home-dir $HOME $USERNAME
# # Allow sudo
# RUN     echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
#         chmod 0440 /etc/sudoers.d/$USERNAME

# # Create workspace base dir
# RUN     mkdir $WORKSPACE
# RUN     chown -R $USERNAME:$USERNAME $WORKSPACE && \
#         chmod 755 -R $WORKSPACE

# ## Switch to non-root
# WORKDIR $HOME
# USER    $USERNAME

ENV DEBIAN_FRONTEND=dialog
