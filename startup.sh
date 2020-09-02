#!/usr/bin/env bash

service rsyslog start
service postfix start

tail -F /var/log/mail.log
