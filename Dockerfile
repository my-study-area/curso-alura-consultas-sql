FROM mysql:8.0.23

ENV BACKUP_PATH /backup
RUN mkdir -p $BACKUP_PATH
WORKDIR $$BACKUP_PATH
COPY backup.sql ./
