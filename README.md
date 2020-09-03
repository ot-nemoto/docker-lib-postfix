# docker-lib-postfix

## はじめに

- Postfixのdockerイメージを作成
- OS: Ubuntu20.04
- 外部メールサーバを指定して送信することを目的としている為、外部メールサーバの設定が必要

## docker build

```sh
docker build -t nemodija/postfix:0.9.1 .
```

## docker run

```sh
docker run -d -it -p 25:25 --privileged \
    --name mail nemodija/postfix:0.9.1
```

### 送信メールサーバを指定し起動

```sh
docker run -d -it -p 25:25 --privileged \
    -e RELAYHOST=[smtp.example.com]:587 \
    -e MAIL_ADDRESS=<user> \
    -e MAIL_PASSWORD=<password> \
    --name mail nemodija/postfix:0.9.1
```
