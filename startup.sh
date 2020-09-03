#!/usr/bin/env bash

postconf relayhost=${RELAYHOST}

if [ -n "${RELAYHOST}" ]; then
  cat <<EOT > /etc/postfix/sasl_passwd
${RELAYHOST} ${MAIL_ADDRESS}:${MAIL_PASSWORD}
EOT
  chmod 600 /etc/postfix/sasl_passwd
  postmap hash:/etc/postfix/sasl_passwd
fi

MYNETWORK=${MYNETWORK_HOST:+$(dig ${MYNETWORK_HOST} +short)}
postconf mynetworks=127.0.0.0/8${MYNETWORK:+,${MYNETWORK}}

service rsyslog start
service postfix start

tail -F /var/log/mail.log
