# Подготовка Oracle

## 1. Пререквизиты
docker образы:
* ```oracle/database:12.2.0.1-ee```

## 2. Разворачивание БД
```
docker run --name oracledb -p 1521:1521 -p 5500:5500 -v oradata:/opt/oracle/oradata oracle/database:12.2.0.1-ee
```

## 3. Создание Pluggable Database

### 3.1 Подключаемся к бд
```
docker exec -it oracledb sqlplus sys@@ORCLCDB as sysdba
```

Пароль указан в логах при создании контейнера

### 3.2 Просмотр текущих Pluggable Database
```
show pdbs
```

### 3.3 Создание Pluggable Database
Название PDB: PEGA01

```
ALTER SYSTEM SET db_create_file_dest = '/opt/oracle/oradata/';
CREATE PLUGGABLE DATABASE PEGA01 ADMIN USER pdbadmin IDENTIFIED BY rules DEFAULT TABLESPACE users DATAFILE SIZE 1M AUTOEXTEND ON NEXT 1M;
```

### 3.4 Открытие базы
```
alter pluggable database PEGA01 open;
```

### 3.5 Подключение к базе
```
docker exec -it oracledb sqlplus pdbadmin/rules@localhost:1521/PEGA01
```

## 4 Создание пользователей

Копирование скрипта в контейнер:
```
docker cp oracle/prepare.sql oracledb:/tmp/
```
Запуск скрипта
```
docker exec -it oracledb sqlplus sys/omTOMy758sg=1@localhost:1521/PEGA01 as sysdba @/tmp/prepare.sql
```
