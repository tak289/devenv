##
## LaTeX
##

ARG     REPO=""
ARG     DIST="debian"
ARG     VARIANT="stable"

FROM    ${REPO}${DIST}:${VARIANT}  AS buildenv

LABEL   org.opencontainers.image.title="LaTeX"
LABEL   org.opencontainers.image.version="1.2.0"
LABEL   org.opencontainers.image.authors="tak289 <50550259+tak289@users.noreply.github.com>"
LABEL   org.opencontainers.image.description="Dev and build environment for LaTeX."
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
        git \
        bash

## LaTeX
RUN     apt-get -qy install --no-install-recommends \
        texlive-latex-recommended \
        texlive-fonts-extra \
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

ENV     DEBIAN_FRONTEND=dialog
