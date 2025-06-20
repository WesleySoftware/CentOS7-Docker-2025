#!/bin/bash
set -eux

IMAGE_NAME="centos7-test-image"

# Build the docker image
docker build -t "${IMAGE_NAME}" .

# Run tests inside the container
docker run --rm -i "${IMAGE_NAME}" /bin/bash -s <<'EOF'
set -eux

# 1. Check if repo files exist
echo "--> Checking for repository files..."
test -f /etc/yum.repos.d/CentOS-SCLo-rh.repo
test -f /etc/yum.repos.d/CentOS-SCLo-scl.repo
test -f /etc/yum.repos.d/CentOS-Vault.repo
test -f /etc/yum.repos.d/EPEL-Vault.repo
echo "--> Repository files are present."

# 2. Check yum repolist
echo "--> Checking yum repolist..."
yum repolist
yum repolist | grep -q "Vault-base"
yum repolist | grep -q "centos-sclo-rh"
yum repolist | grep -q "centos-sclo-scl"
yum repolist | grep -q "epel"
echo "--> Repositories are enabled."

# 3. Test installing packages from repositories
echo "--> Testing package installation from repositories..."

# Install 'which' command to test for executables
yum install -y which

# Test EPEL
echo "--> Testing EPEL repository..."
yum install -y htop
which htop
yum remove -y htop

# Test SCLo rh
echo "--> Testing SCLo rh repository..."
yum install -y rh-python38
scl enable rh-python38 'python --version'
yum remove -y rh-python38

# Test SCLo scl
echo "--> Testing SCLo scl repository..."
yum install -y python27
scl enable python27 'python --version'
yum remove -y python27

echo "--> Package installation tests passed."

echo "All tests passed!"
EOF