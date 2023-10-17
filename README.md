# Running the container

```
version: '3.1'

services:
  mysql:
    image: mysql:latest
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: mydb
      MYSQL_USER: myuser
      MYSQL_PASSWORD: mypassword
    volumes:
      - mysql-data:/var/lib/mysql

  mysqldump:
    build: .
    environment:
      DB_HOST: mysql
      DB_PORT: 3306
      DB_USER: myuser
      DB_PASSWORD: mypassword
      DB_NAME: mydb
      DUMP_INTERVAL: 3600
      DUMP_DIR: /dumps
      RETENTION_DAYS: 7
    volumes:
      - ./dumps:/dumps

volumes:
  mysql-data:
```
