#!/bin/bash
set -ex
hostname master.vm
echo '192.168.55.4 master.vm master' >> /etc/hosts
mkdir -p /etc/puppetlabs/puppet
echo '*' > /etc/puppetlabs/puppet/autosign.conf


curl -Lo pe.archive 'https://pm.puppetlabs.com/puppet-enterprise/2019.0.1/puppet-enterprise-2019.0.1-el-7-x86_64.tar.gz'

tar -xf pe.archive
cat > pe.conf <<-EOF
{
  "console_admin_password": "puppetlabs"
  "puppet_enterprise::puppet_master_host": "%{::trusted.certname}"
  "puppet_enterprise::profile::master::check_for_updates": false
  "puppet_enterprise::profile::master::r10k_remote": "http://gitlab.vm/puppet/control-repo.git"
  "puppet_enterprise::profile::master::code_manager_auto_configure": true
}
EOF

./puppet-enterprise-*-el-7-x86_64/puppet-enterprise-installer -c pe.conf

# Grab a deploy token
echo "puppetlabs" | /opt/puppetlabs/bin/puppet-access login admin --lifetime 365d

systemctl stop firewalld
systemctl disable firewalld

# When the agent returns a non-zero exit code (i.e. Puppet made changes, we still want Vagrant to not report an error.
/usr/local/bin/puppet agent -t || true

yum -y install git

# Get a "starter" control-repo
cd /etc/puppetlabs/code/environments; rm -rf production
git clone https://github.com/mtsprout/control-repo.git /etc/puppetlabs/code/environments/production/
cd /etc/puppetlabs/code/environments/production
chown -R pe-puppet:pe-puppet *
git remote remove origin
git remote add origin http://gitlab.vm/puppet/control-repo
