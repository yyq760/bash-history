#/bin/bash
# get user ip address
# version 1.0
# last changes: 20210402
# author: yyq760@163.com
# changelog:
#     @20210111 user's history file can only be viewed by themselves
#     @20210402 HISTCONTROL add options
env | grep SSH_CLIENT > /dev/null 2>&1
if [ $? -eq 0 ];then
    USER_IP=$(echo $SSH_CLIENT | awk '{print $1}')
else
    # rhel/centos
    USER_IP=$(who -u am i 2> /dev/null | awk '{print $NF}' | sed 's/[()]//g')
    # debian
    # USER_IP=$(who -u --ips am i 2> /dev/null | awk '{print $NF}' | sed 's/[()]//g')
    if [ -z $USER_IP ];then
        USER_IP=$(hostname)
    fi
fi

# create history file & chmod
if [ $UID -eq 0 ];then
    readonly HISTFILE=~/.bash_history
    sh /etc/cron.hourly/hist
else
    readonly HISTFILE=/var/log/history/$USER-$UID.log
    touch $HISTFILE
    chmod 600 $HISTFILE > /dev/null 2>&1 # add @ 20210111
    chown $UID:$(id -g $USER) $HISTFILE > /dev/null 2>&1
fi
readonly HISTFILESIZE=50000
readonly HISTTIMEFORMAT="<%F %T>: "
readonly HISTSIZE=1000
# Uncomment this line to ignore the command which start with space or repeat continuous
# readonly HISTCONTROL=ignoreboth
# Uncomment this line to ignore the command which repeat continuous
readonly HISTCONTROL=ignoredups # default

# append to the history file, don't overwrite it
shopt -s histappend
# logger
export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local7.debug "${USER}@${USER_IP} : PID[$$] PPID[${PPID}] : @$PWD : $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*<.*>://" ) RETURN[$RETRN_VAL]"'
readonly PROMPT_COMMAND
