#!/bin/bash
dir=$(dirname $0)

# cp files
/bin/cp -fv ${dir}/files/HIST.sh       /etc/profile.d/HIST.sh
/bin/cp -fv ${dir}/files/hist          /etc/cron.hourly/hist
/bin/cp -fv ${dir}/files/history.conf  /etc/rsyslog.d/history.conf
chmod 755 /etc/cron.hourly/hist
# create & import
/bin/bash ${dir}/files/hist
source /etc/profile.d/HIST.sh
# restart rsyslog
service rsyslog restart
