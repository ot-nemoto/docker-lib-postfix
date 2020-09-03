FROM ubuntu:20.04

RUN apt -y update && \
    DEBIAN_FRONTEND=noninteractive apt -y install iproute2 postfix rsyslog sasl2-bin dnsutils

WORKDIR /root

COPY config/main.cf main.cf
RUN cat main.cf | while read line; do   postconf $(echo $line | tr -d ' ') ; done

COPY config/master.cf master.cf
RUN cat master.cf | tee -a /etc/postfix/master.cf

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY startup.sh startup.sh
RUN chmod +x startup.sh

EXPOSE 25

CMD ["./startup.sh"]
