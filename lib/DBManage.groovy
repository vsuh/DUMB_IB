
def Common

def clusterIdentifierFromRAS(rasHostnameOrIP, rasPort, clusterName1C) {
    def command = "${env.JN_RAC}  ${rasHostnameOrIP}:${rasPort} cluster list | grep -B1 '${clusterName1C}' | head -1 | tr -d ' ' | cut -d ':' -f 2"

    def clusterId = Common.cmdReturnStdout(command)
    echo "[-- " + clusterId + " --]"
    clusterId = clusterId.trim()

    if (env.JN_VERBOSE == 'true') {
        echo 'VERBOSE: clusterId = ' + clusterId
    }

    return clusterId
}

def databaseIdentifierFromRAS(rasHostnameOrIP, rasPort, clusterId, databaseName1C, clstAdmin, clstPasswd) {
    def command = "${env.JN_RAC} ${rasHostnameOrIP}:${rasPort} infobase --cluster ${clusterId} --cluster-user ${clstAdmin} --cluster-pwd ${clstPasswd} summary list | grep -B1 '${databaseName1C}' | head -1 | tr -d ' ' | cut -d ':' -f 2"
    def databaseId = Common.cmdReturnStdout(command)
    databaseId = databaseId.trim()

    if (env.JN_VERBOSE == 'true') {
        echo 'VERBOSE: databaseId = ' + databaseId
    }

    return databaseId
}

def deleteConnectionsIBbyID(rasHostnameOrIP, rasPort, clusterId, databaseId, clstAdmin, clstPasswd) {
    if (databaseId != '') {
        def command = "${env.JN_RAC} ${rasHostnameOrIP}:${rasPort}  session --cluster ${clusterId} --cluster-user ${clstAdmin}  --cluster-pwd ${clstPasswd} list --infobase=${databaseId} | grep 'session ' | tr -d ' ' | cut -d ':' -f 2 | while read line ; do  ${env.JN_RAC} ${rasHostnameOrIP}:${rasPort}  session --cluster ${clusterId} --cluster-user ${clstAdmin} --cluster-pwd ${clstPasswd}  terminate --session=\$line; done"

        if (env.JN_VERBOSE == 'true') {
            echo 'VERBOSE: cmd = ' + command
        }
        Common.cmd(command)
    }
}

def lockIBbyID(rasHostnameOrIP, rasPort, clusterId, clstAdmin, clstPasswd, databaseId, ibAdmin, ibPwd, lockMessage, lockCode) {
    def TimeNow = Common.TimeNow()
    def NowPlus5min =  Common.formatDate(Common.addMinutes(Common.TimeNow(), 5))
    if (databaseId != '') {
        def command = "${env.JN_RAC} ${rasHostnameOrIP}:${rasPort}  infobase --cluster ${clusterId} --cluster-user ${clstAdmin} --cluster-pwd ${clstPasswd}  update --infobase=${databaseId}  --infobase-user=${ibAdmin} --infobase-pwd=${ibPwd}  --denied-from=${TimeNow} --denied-to=${NowPlus5min} --permission-code=\"${lockCode}\" --denied-message=\"${lockMessage}\"  --sessions-deny=\"on\" --scheduled-jobs-deny=\"on\""

        if (env.JN_VERBOSE == 'true') {
            echo 'VERBOSE: cmd = ' + command
        }

        Common.cmd(command)
    }
    sleep(5)
}

def unlockIBbyID(rasHostnameOrIP, rasPort, clusterId, clstAdmin, clstPasswd, databaseId, ibAdmin, ibPwd) {
    if (databaseId != '') {
        def command = "${env.JN_RAC} ${rasHostnameOrIP}:${rasPort}  infobase --cluster ${clusterId} --cluster-user ${clstAdmin} --cluster-pwd ${clstPasswd}  update --infobase=${databaseId}  --infobase-user=${ibAdmin} --infobase-pwd=${ibPwd}  --sessions-deny=\"off\" "
        if (env.JN_VERBOSE == 'true') {
            echo 'VERBOSE: cmd = ' + command
        }
        Common.cmd(command)
    }
    sleep(5)
}
// def deleteConnectionsViaRas(rasHostnameOrIP, rasPort, clusterName, databaseName, kill1CProcesses = true) {

//     if (env.VERBOSE == "true") {
//         echo "Trying to delete connections to database ${databaseName} via RAS"
//     }

//     def clusterId = clusterIdentifierFromRAS(rasHostnameOrIP, rasPort, clusterName)
//     def databaseId = databaseIdentifierFromRAS(rasHostnameOrIP, rasPort, clusterId, databaseName)

//     if (databaseId != "") {
//         def command = "${env.INSTALLATION_DIR_1C}/rac ${rasHostnameOrIP}:${rasPort} session --cluster ${clusterId} list --infobase=${databaseId}  | grep 'session ' | tr -d ' ' | cut -d ':' -f 2 | while read line ; do  ${env.INSTALLATION_DIR_1C}/rac session --cluster ${clusterId} terminate --session=\$line; done"
//         commonMethods.cmd(command)
//     }

//     if (kill1CProcesses) {
//         commonMethods.killProcessesByRegExp("${env.INSTALLATION_DIR_1C}/1cv8")
//     }

//     sleep(5)

// }

// Return this module as Groovy object
return this
