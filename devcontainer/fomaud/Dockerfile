##
## AuD
##

ARG     DIST="ubuntu"
ARG     VARIANT="noble"

FROM    ${DIST}:${VARIANT}  AS buildenv

LABEL   org.opencontainers.image.title="fomaud"
LABEL   org.opencontainers.image.version="1.2.0"
LABEL   org.opencontainers.image.authors="tak289 <50550259+tak289@users.noreply.github.com>"
LABEL   org.opencontainers.image.description="Dev and build environment for AuD lecture."
LABEL   org.opencontainers.image.source=https://github.com/tak289/devenv
LABEL   org.opencontainers.image.licenses=MIT
LABEL   org.opencontainers.image.revision="${GITHUB_SHA}"

## Vars
ARG     USERNAME=dev
ARG     USER_UID=1000
ARG     USER_GID=$USER_UID

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

# Python - Create venv dir
RUN     mkdir $VIRTUAL_ENV
COPY    requirements.txt $VIRTUAL_ENV/requirements.txt

# Setting up virtual env
RUN     umask 0022 && python3 -m venv $VIRTUAL_ENV
ENV     PATH="$VIRTUAL_ENV/bin:$PATH"

RUN     $VIRTUAL_ENV/bin/pip3 install -r $VIRTUAL_ENV/requirements.txt

ENV     DEBIAN_FRONTEND=dialog
