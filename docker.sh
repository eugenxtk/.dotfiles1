#!/usr/bin/env bash
set -e

apt remove -y docker docker.io containerd runc || true

set +e
apt remove -y -q docker-engine || true
set -e

apt update

apt install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null

apt update

apt install -y docker-ce docker-ce-cli containerd.io

apt install -y docker-compose
