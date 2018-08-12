# Установка Pega

## 1. Пререквизиты

* Диструбитив Pega
* Подготовлена БД ([oracle/Readme.md](../oracle/Readme.md))
* JDBC драйвер (ojdbc7.jar, ojdbc8.jar или postgresql-42.2.1.jar)

## 2. Установка

## 2.1 Настройка установщика

Свойства scripts/setupDatabase.properties:
```
pega.jdbc.driver.jar/{Путь до jdbc драйвера}/ojdbc7.jar
pega.jdbc.driver.class=oracle.jdbc.OracleDriver
pega.database.type=oracledate
pega.jdbc.url=jdbc:oracle:thin:@//localhost:1521/PEGA01
pega.jdbc.username=deploy
pega.jdbc.password=deploy

rules.schema.name=prpcrules
data.schema.name=prpcdata
system.name=pega01

```

## 2.2 Запуск установки



Запустить скрипт
```
cd scripts
./install.sh
```

## 2.3 Окончание установки

```
Install Finalization:
     [echo] PegaRULES Process Commander database load complete.

BUILD SUCCESSFUL
Total time: 41 minutes 7 seconds
```

После окончания установки можно удалить пользователя ```deploy```
```
DROP USER DEPLOY CASCADE;
```