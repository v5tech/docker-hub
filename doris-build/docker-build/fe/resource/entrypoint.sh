#!/bin/bash

DORIS_META="${DORIS_HOME}/doris-meta"
FE_IP=$(ip addr show eth0 | grep inet | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}/" | tr -d '/')

echo "DEBUG >>>>>> doris_role: ${DORIS_ROLE}"

need_init=1

check_need_init() {
    if [ "$(ls -A "${DORIS_META}")" ]; then
        need_init=0
    else
        need_init=1
    fi
}

init_doris() {
    local i
    for i in {120..0}; do
        mysql -uroot -h"${FE_IP}" -P9030 -e "SELECT 1" &>/dev/null
        code=$?
        if [[ ${code} == 0 ]]; then
            break
        fi
        sleep 1
    done
    if [[ "${i}" == 0 ]]; then
        echo "DEBUG >>>>>> Unable to start server."
        exit 1
    fi
    echo "DEBUG >>>>>> begin to init doris fe"
    mysql -uroot -h"${FE_IP}" -P9030 < /docker-entrypoint-initdb.d/init.sql
    code=$?
    if [[ ${code} == 0 ]]; then
        echo "DEBUG >>>>>> sucess to init doris fe"
    else
        echo "DEBUG >>>>>> faild to init doris fe"
        exit 1
    fi
}

if [[ ${DORIS_ROLE} == 'fe-leader' ]]; then
    check_need_init
    registerShell="${DORIS_HOME}/bin/start_fe.sh --daemon"
    eval "${registerShell}"
    echo "DEBUG >>>>>> FE is master, fe_ip = ${FE_IP}"
    echo "DEBUG >>>>>> registerShell = ${registerShell}"
    echo "DEBUG >>>>>> check_need_init, need_init = ${need_init}"
    if [[ "${need_init}" == 1 ]]; then
        echo "DEBUG >>>>>> init_doris"
        init_doris
    fi
    tail -f "${DORIS_HOME}"/log/fe.out
elif [[ ${DORIS_ROLE} == 'fe-follower' ]]; then
    ## if current node is not master
    ## PREPARE1: registe follower from mysql client
    ## PREPARE2: call start_fe.sh using --help optional
    ## STEP1: check master fe service works
    ## STEP2: if feMasterStat == true; register PREPARE1 & PREPARE2 [retry 3 times, sleep 10s]

    ## PREPARE1: registe follower from mysql client
    registerMySQL="mysql -uroot -h${FE_IP} -P9030 -e \"alter system add follower '${FE_IP}:9010'\""

    ## PREPARE2: call start_fe.sh using --help optional
    registerShell="${DORIS_HOME}/bin/start_fe.sh --helper '${FE_IP}:9010'"

    echo "DEBUG >>>>>> FE is follower, fe_ip = ${FE_IP}"
    echo "DEBUG >>>>>> registerMySQL = 【${registerMySQL}】"
    echo "DEBUG >>>>>> registerShell = 【${registerShell}】"
    echo "DEBUG >>>>>> feMasterStat =  【mysql -uroot -P9030 -h ${FE_IP} -e \"show frontends\" | grep \"${FE_IP}_9010\" | grep -E \"true[[:space:]]*true\"】"

    ## STEP1: check FE master status
    for ((i = 0; i <= 2000; i++)); do
        ## run STEP1 & STEP2, and then break
        echo "Run registerShell command, [ registerMySQL = ${registerMySQL} ]"
        eval "${registerMySQL}"
        sleep 2

        ## followerJoined: Joined = 0, doesn't join = 1
        mysql -uroot -h"${FE_IP}" -P9030 -e "show frontends" | grep "${FE_IP}_9010" | grep -E "false[[:space:]]*false"
        followerJoined=$?

        if [[ "${followerJoined}" == 0 ]]; then
            echo "Run registerShell command, [ registerShell = ${registerShell} ]"
            eval "${registerShell}"
            echo "The resutl of run registerShell command, [ res = $? ]"
        fi
        sleep 5
    done
fi