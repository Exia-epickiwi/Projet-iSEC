#!/bin/bash

$basepath = $(pwd)

echo Restauration complete Centreon dans /tmp/cbak
echo ---------------------------------------
echo

cd /
echo "- Extraction de l'archive général"
tar -xzf ${basepath}/centreon-backup.tar.gz

echo "- Configuration général Centreon"
tar -xzf /tmp/cbak/etc_centreon.tar.gz
echo "- Configurations des moteurs de récuperation"
tar -xzf /tmp/cbak/etc_centreon-engine.tar.gz
echo "- Configuration des collecteurs de données"
tar -xzf /tmp/cbak/etc_centreon-broker.tar.gz
echo "- Binaires centreon"
tar -xzf /tmp/var_lib_centreon.tar.gz
echo "- Plugins Nagios"
tar -xzf /tmp/cbak/var_lib_nagios_plugins.tar.gz
echo "- Configuration apache2"
tar -xzf /tmp/cbak/etc_httpd_confd.tar.gz
echo "- Configuration logging"
tar -xzf /tmp/cbak/etc_logrotated.tar.gz
echo "- Logs Centron"
tar -xzf /tmp/cbak/var_log_centreon.tar.gz
echo "- Logs des moteurs de recuperation"
tar -xzf /tmp/cbak/var_log_centreon-engine.tar.gz
echo "- Logs des collecteurs de données"
tar -xzf /tmp/cbak/var_log_centreon-broker.tar.gz

echo "- Base de données principal Centreon"
mysql -u root centreon < /tmp/cbak/backup_centreon.sql
echo "- Base de données de stockage"
mysql -u root centreon_storage < /tmp/cbak/backup_centreon_storage.sql
echo "- Configuration mysql"
mysql -u root mysql < /tmp/cbak/backup_mysql.sql

cd $basepath
