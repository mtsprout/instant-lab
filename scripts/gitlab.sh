#!/bin/bash

# Basic system requirements for GitLab per install instructions
# To be puppetized
sudo yum install -y curl policycoreutils-python openssh-server
sudo systemctl enable sshd
sudo systemctl start sshd
sudo firewall-cmd --permanent --add-service=http
sudo systemctl reload firewalld

mkdir /etc/gitlab && touch /etc/gitlab/skip-auto-reconfigure

# Add GitLab package repo
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash

# Install GitLab
sudo EXTERNAL_URL="http://192.168.55.50" yum install -y gitlab-ee

# Set default password
# Trying to figure out how to bypass the inital web prompt to change sign on.
# It's super hacky, but I may have to just end up creating a tarball of an
# "gold" gitlab install with some initial setup already completed.
echo 'u = User.where(id:1).first
u.password = "swordfish"
u.password_confirmation = "swordfish"
u.save!' | gitlab-rails console production

# Quick entry for /etc/hosts
sed -i -e '1d' /etc/hosts
echo "192.168.55.4    master.vm master puppet" >> /etc/hosts
echo -e "$1    \t$FULLHOST\t\t$SHORT_HOST" >> /etc/hosts

# Install agent
curl -k https://master.vm:8140/packages/current/install.bash | bash

# Puppet run while this thing gets Puppetized
/opt/puppetlabs/bin/puppet agent -t || true
