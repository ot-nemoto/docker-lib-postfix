#!/usr/bin/env bash

postconf relayhost=${RELAYHOST}

if [ -n "${RELAYHOST}" ]; then
  cat <<EOT > /etc/postfix/sasl_passwd
${RELAYHOST} ${MAIL_ADDRESS}:${MAIL_PASSWORD}
EOT
  chmod 600 /etc/postfix/sasl_passwd
  postmap hash:/etc/postfix/sasl_passwd
fi

service rsyslog start
service postfix start

tail -F /var/log/mail.log
