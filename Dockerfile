FROM python:3.9-slim

# Install notebook packages
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab jupyterhub

# Install sudo
RUN apt-get update && \
    apt-get install -y --no-install-recommends sudo && \
    rm -rf /var/lib/apt/lists/*

# Create user with a home directory
ARG NB_USER
ARG NB_UID

ENV USER=${NB_USER}
ENV HOME=/home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER} && \
    echo "${NB_USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${NB_USER} && \
    chmod 0440 /etc/sudoers.d/${NB_USER}

WORKDIR ${HOME}
USER ${USER}
