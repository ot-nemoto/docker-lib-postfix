# mail-container

## はじめに

- Postfixのdockerイメージを作成
- OS: Ubuntu20.04
- 外部メールサーバを指定して送信することを目的としている為、外部メールサーバの設定が必要

## docker build

*Edit config/main.cf*

```sh
# (e.g.)
RELAYHOST=[mail.example.com]:587
sed -i "s/^\(relayhost\).*/\1 = ${RELAYHOST}/g" config/main.cf
```

*Make sasl_passwd*

```sh
cat <<EOT > sasl_passwd
${RELAYHOST} <user>:<pass>
EOT
```

*Build*

```sh
docker build -t nemodija/postfix:0.1 .
```

## docker run

```sh
docker run -d -it -p 25:25 --privileged --name mail nemodija/postfix:0.1
```
