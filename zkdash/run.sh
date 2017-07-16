#!/bin/sh
sed -Ei 's/<DB_NAME>/'$DB_NAME'/g' ./conf/conf.yml
sed -Ei 's/<DB_HOST>/'$DB_HOST'/g' ./conf/conf.yml
sed -Ei 's/<DB_PORT>/'$DB_PORT'/g' ./conf/conf.yml
sed -Ei 's/<DB_USER>/'$DB_USER'/g' ./conf/conf.yml
sed -Ei 's/<DB_PWD>/'$DB_PWD'/g' ./conf/conf.yml

python ./bin/syncdb.py
python init.py -port=8765