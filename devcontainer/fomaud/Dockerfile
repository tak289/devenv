##
## AuD
##

# FROM    debian:stable  AS buildenv
# FROM    ubuntu:jammy  AS buildenv
FROM    ubuntu:noble  AS buildenv

LABEL   version="1.0.0"
LABEL   description="Dev and build environment for AuD lecture."
LABEL   com.example.vendor="tak289"
LABEL   org.opencontainers.image.authors="tak289"
LABEL   description="Dev and build environment for AuD lecture."

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

## C/C++ Development environment
RUN     apt-get -qy install --no-install-recommends \
        cmake \
        build-essential

## C/C++ - Boost
RUN     apt-get -qy install --no-install-recommends \
        libboost-all-dev

## C/C++ - Additional libraries
RUN     apt-get -qy install --no-install-recommends \
        libgtest-dev \
        googletest

## C/C++ - Additional applications
RUN     apt-get -qy install --no-install-recommends \
        valgrind \
        gdb \
        doxygen \
        graphviz

## Python
RUN     apt-get -qy install --no-install-recommends \
        python3 \
        python3-venv \
        python3-pip
ENV     VIRTUAL_ENV=/opt/venv

# ## Setup non-root dev user
# ENV     HOME /home/$USERNAME
# RUN     groupadd --gid $USER_GID $USERNAME && \
#         useradd --uid $USER_UID --gid $USER_GID --create-home --home-dir $HOME $USERNAME
# # Allow sudo
# RUN     echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
#         chmod 0440 /etc/sudoers.d/$USERNAME

# Python - Create venv dir
RUN     mkdir $VIRTUAL_ENV
COPY    requirements.txt $VIRTUAL_ENV/requirements.txt
# RUN     chown -R $USERNAME:$USERNAME $VIRTUAL_ENV && \
#         chmod 755 -R $VIRTUAL_ENV

# # Create workspace base dir
# RUN     mkdir $WORKSPACE
# RUN     chown -R $USERNAME:$USERNAME $WORKSPACE && \
#         chmod 755 -R $WORKSPACE

# ## Switch to non-root
# WORKDIR $HOME
# USER    $USERNAME
# ENV     VIRTUAL_ENV=/opt/venv

# Setting up virtual env
RUN     python3 -m venv $VIRTUAL_ENV
ENV     PATH="$VIRTUAL_ENV/bin:$PATH"

RUN     $VIRTUAL_ENV/bin/pip3 install -r $VIRTUAL_ENV/requirements.txt

ENV DEBIAN_FRONTEND=dialog
