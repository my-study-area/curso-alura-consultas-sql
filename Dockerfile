FROM mysql:8.0.23

ENV BACKUP_PATH /backup
RUN mkdir -p $BACKUP_PATH
WORKDIR $$BACKUP_PATH
COPY sucos_vendas_database.sql ./
COPY my.cnf /etc/mysql/
