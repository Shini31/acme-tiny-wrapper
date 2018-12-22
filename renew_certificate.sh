#!/bin/sh
###
# Version   Date       Author    Description
#------------------------------------------------
# 1.0       27/03/16   Shini31   Initial version
# 2.0       22/12/18   Shini31   Migrate to acme.sh
#
###

#Global variables
LOGFILE="/var/log/acme-tiny.log"
TIMESTAMP=`date "+%Y-%m-%d %H:%M:%S"`

HTTPSERVER=apache2

ACMEDIR=/home/user/.acme.sh
ACME=acme.sh
DOMAINS=(domain1 domain2 domain3)

#Check variables
[ -f $ACMEDIR/$ACME ] || { echo -e "${TIMESTAMP} - Binary acme-tiny not found" > ${LOGFILE}; exit 1; }

#Generate new certificate(s)
for DOMAIN in "${DOMAINS[@]}"
do
    echo -e "${TIMESTAMP} - Generating certificate for ${DOMAIN}" > ${LOGFILE}
    $ACMEDIR/$ACME --renew -d $DOMAIN 2> ${LOGFILE} || { echo -e "${TIMESTAMP} - Error occurs with renewing ${DOMAIN} certificate" > ${LOGFILE}; exit 1; }
done


#Reload HTTP server for new certificate(s)
sudo service ${HTTPSERVER} reload || { echo -e "${TIMESTAMP} - Cannot reload apache" > ${LOGFILE}; exit 1; }
