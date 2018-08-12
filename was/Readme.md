# Установка Pega (WAS + Oracle)

## 1. Пререквизиты

* [Pega Deployment Guides](https://community1.pega.com/support-resources/deployment-upgrades/deployment-guides)

* Дистрибутив Pega

* Подготовить Oracle ([oracle/Readme.md](../oracle/Readme.md))

* Установить Pega (
[pega-install/Readme.md](../pega-install/Readme.md))

* docker-image: ```ibmcom/websphere-traditional:8.5.5.13-profile```

## 2. Настройка

### 2.1 Запуск WAS

```
docker run -d --name pega01_web --hostname A101101 -e UPDATE_HOSTNAME=true -p 9080:9080 -p 9043:9043 -p 9443:9443 ibmcom/websphere-traditional:8.5.5.13-profile 
```

### 2.2 Вход в WAS

[https://localhost:9043/ibm/console/logon.jsp](https://localhost:9043/ibm/console/logon.jsp)

Логин: ```wsadmin```

Пароль:
```
docker exec pega01_web cat /tmp/PASSWORD
```

## 2.3 Настройка

Зайти под root и создать папку LOGS
```
docker exec -it -u root pega01_web bash
mkdir /LOGS
chown was:was /LOGS
```
Под обычным пользователем
```
docker exec -it pega01_web bash
mkdir -p /opt/oracle
chown was:was /opt/oracle
```

Скопировать jdbc драйвер
```
docker cp ojdbc7.jar pega01_web:/opt/oracle
```

Далее настроить по рук-ву начиная с главы ```Configuring the application server```