#!/bin/bash

FE_IP=doris-fe
BE_IP=$(ip addr show eth0 | grep inet | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}/" | tr -d '/')

echo "DEBUG >>>>>> doris_role: ${DORIS_ROLE}"

registerMySQL="mysql -uroot -h${FE_IP} -P9030 -e \"alter system add backend '${BE_IP}:9050'\""
echo "DEBUG >>>>>> registerMySQL = ${registerMySQL}"

registerShell="${DORIS_HOME}/bin/start_be.sh --daemon"
echo "DEBUG >>>>>> registerShell = ${registerShell}"

echo "DEBUG >>>>>> run command ${registerShell}"
eval "${registerShell}"

for ((i = 0; i <= 20; i++)); do
    ## check be register status
    echo "mysql -uroot -h${FE_IP} -P9030 -e \"show backends\" | grep \"${BE_IP}\" | grep \"9050\""
    mysql -uroot -h"${FE_IP}" -P9030 -e "show backends" | grep "${BE_IP}" | grep "9050"
    be_join_status=$?
    echo "DEBUG >>>>>> The " "${i}" "time to register BE node, be_join_status=${be_join_status}"
    if [[ "${be_join_status}" == 0 ]]; then
        ## be registe successfully
        echo "DEBUG >>>>>> be registe successfully"
        tail -f "${DORIS_HOME}"/log/be.INFO
    else
        ## be doesn't registe
        echo "DEBUG >>>>>> run commnad ${registerMySQL}"
        eval "${registerMySQL}"
        if [[ "${i}" == 20 ]]; then
            echo "DEBUG >>>>>> BE Start Or Register FAILED!"
        fi
        sleep 5
    fi
done
