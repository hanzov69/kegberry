#!/bin/bash
# Kegbone install script.
# Based on Kegberry install script
# Original Source: https://github.com/Kegbot/kegberry


set -e
set -x

### Configuration section

REQUIRED_PACKAGES="nginx-light libjpeg-dev supervisor python-setuptools python-dev libsqlite3-dev libmysqlclient-dev mysql-server memcached redis-server"
#KILL_PACKAGES="gnome-* xserver-* xscreensaver* apache* avahi-daemon xchat* tight* lxde-common lxpanel lxsession lxterminal"
KEGBONE_DIR="/etc/kegbone"

KEGBOT_PIP_NAME="kegbot"
PYCORE_PIP_NAME="kegbot-pycore"

NGINX_CONF_URL="https://raw.github.com/hanzov69/kegbone/master/system-files/kegbot-nginx.conf"
SUPERVISOR_CONF_URL="https://raw.github.com/hanzov69/kegbone/master/system-files/kegbot-supervisor.conf"

### Functions

error() {
  echo "Error: $@"
  exit 1
}

info() {
  echo "---" $@
}

do_apt_get() {
  sudo bash -c "DEBIAN_FRONTEND=noninteractive apt-get -yq $*"
}

remove_bbb_cruft() {
  sudo systemctl disable cloud9.service
  sudo systemctl disable bonescript.service
  sudo systemctl disable bonescript.socket
  sudo systemctl disable bonescript-autorun.service
  #sudo systemctl disable avahi-daemon.service
}

remove_other_cruft() {
  sudo apt-get -y purge --auto-remove $*
}

install_kegbone() {
  sudo mkdir -p ${KEGBONE_DIR}
  
#  info "Removing unnecessary software to free up space ..."
#  remove_other_cruft ${KILL_PACKAGES}
  
#  info "Removing unnecessary BeagleBone software/services ..."
#  remove_bbb_cruft

  info "Updating distro ..."
  do_apt_get update
  do_apt_get upgrade

  info "Installing required packages ..."
  do_apt_get install ${REQUIRED_PACKAGES}

  info "Upgrading pip ..."
  sudo pip install -U pip
  
  info "Installing amqp ..."
  sudo pip2 install amqp
  
  info "Installing anyjson ..."
  sudo pip2 install anyjson
  
  info "Installing six ..."
  sudo pip2 install six

  info "Installing Kegbot Server ..."
  sudo pip install -U ${KEGBOT_PIP_NAME}

  info "Installing Kegbot Pycore ..."
  sudo pip install -U ${PYCORE_PIP_NAME}

  info "Loading MySQL timezones ..."
  mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root -p mysql

  info "Configuring Kegbot Server ..."
  mysqladmin -u root create kegbot || true
  setup-kegbot.py --db_type=mysql --interactive=false

  info "Generating API key ..."
  api_key=$(kegbot create_api_key "Kegbone")
  mkdir -p /home/kegbot/.kegbot/
  echo "--api_url=http://localhost/api/" > /home/kegbot/.kegbot/pycore-flags.txt
  echo "--api_key=${api_key}" >> /home/kegbot/.kegbot/pycore-flags.txt

  info "Installing configs ..."
  sudo bash -c "curl -o /etc/nginx/sites-available/default ${NGINX_CONF_URL}"
  sudo bash -c "curl -o /etc/supervisor/conf.d/kegbot.conf ${SUPERVISOR_CONF_URL}"

  info "Restarting daemons ..."
  sudo supervisorctl reload
  sudo /etc/init.d/nginx restart

  info "Done! Kegbot has been installed."
}

### Main program
install_kegbone
