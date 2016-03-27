#!/bin/sh
###
# Version   Date       Author    Description
#------------------------------------------------
# 1.0       27/03/16   Shini31   Initial version
#
###

#Global variables
LOGFILE="/var/log/acme-tiny.log"
TIMESTAMP=`date "+%Y-%m-%d %H:%M:%S"`

HTTPSERVER=apache2

PYTHONDIR=/usr/bin/

ACMEDIR=/home/acme/
ACMETINY=acme_tiny.py
ACMECHALLENGESDIR=/home/acme/challenges
ACMEDOMAINDIR=/home/acme/domain
ACMESECRETSDIR=/home/acme/secrets
ACCOUNTKEY=account.key
DOMAINS=(domain1 domain2 domain3)

#Check variables
[ -f $ACMEDIR/$ACMETINY ] || { echo -e "${TIMESTAMP} - Binary acme-tiny not found" > ${LOGFILE}; exit 1; }
[ -f $ACMESECRETSDIR/$ACCOUNTKEY ] || { echo -e "${TIMESTAMP} - Account key not found" > ${LOGFILE}; exit 1; }
[ -d ${ACMEDOMAINDIR} ] || { echo -e "${TIMESTAMP} - Domain directory does not exist" > ${LOGFILE}; exit 1; }
[ -d ${ACMECHALLENGESDIR} ] || { echo -e "${TIMESTAMP} - Challenges directory does not exist" > ${LOGFILE}; exit 1; }
[ -x ${PYTHONDIR}/python ] || { echo -e "${TIMESTAMP} - Binary python not executable" > ${LOGFILE}; exit 1; }

#Get intermediate certificate
curl  https://letsencrypt.org/certs/lets-encrypt-x1-cross-signed.pem \
    > $ACMEDOMAINDIR/intermediate.pem || { echo -e "${TIMESTAMP} - Cannot get intermediate certificate" > ${LOGFILE}; exit 1; }

#Generate new certificate(s)
for DOMAIN in "${DOMAINS[@]}"
do
    echo -e "${TIMESTAMP} - Generating certificate for ${DOMAIN}" > ${LOGFILE}
    ${PYTHONDIR}/python ${ACMEDIR}/${ACMETINY} \
        --account-key ${ACMESECRETSDIR}/${ACCOUNTKEY} \
        --csr ${ACMEDOMAINDIR}/${DOMAIN}.csr \
        --acme-dir ${ACMECHALLENGESDIR} \
        > ${ACMEDOMAINDIR}/${DOMAIN}.crt 2> ${LOGFILE} || { echo -e "${TIMESTAMP} - Error occurs with renewing ${DOMAIN} certificate" > ${LOGFILE}; exit 1; }

        cat ${ACMEDOMAINDIR}/${DOMAIN}.crt ${ACMEWORKDIR}/intermediate.pem > ${ACMEWORKDIR}/${DOMAIN}.pem
done


#Reload HTTP server for new certificate(s)
sudo service ${HTTPSERVER} reload || { echo -e "${TIMESTAMP} - Cannot reload apache" > ${LOGFILE}; exit 1; }
