#/usr/bin/bash
nohup  python3 manage.py runserver 127.0.0.1:8088 > log.file  2>&1 &