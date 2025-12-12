#!/bin/bash
set -e

# Atualiza o sistema
dnf update -y

# Remove versões antigas
dnf remove -y docker docker-client docker-client-latest docker-common docker-latest \
  docker-latest-logrotate docker-logrotate docker-engine

# Dependências
dnf install -y yum-utils device-mapper-persistent-data lvm2

# Repositório oficial Docker
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Instala Docker
dnf install -y docker-ce docker-ce-cli containerd.io

dnf install -y tcpdump openvpn

# Inicia e habilita
systemctl enable --now docker

# Grupo docker
groupadd docker || true
usermod -aG docker vagrant

echo "Docker instalado com sucesso no CentOS 8."