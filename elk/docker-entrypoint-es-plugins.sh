#!/bin/bash

bin/elasticsearch-plugin install analysis-icu
bin/elasticsearch-plugin install analysis-smartcn
bin/elasticsearch-plugin install analysis-phonetic
bin/elasticsearch-plugin install ingest-attachment
bin/elasticsearch-plugin install --batch https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.15.2/elasticsearch-analysis-ik-7.15.2.zip
bin/elasticsearch-plugin install --batch https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v7.15.2/elasticsearch-analysis-pinyin-7.15.2.zip
bin/elasticsearch-plugin install repository-s3

exec /usr/local/bin/docker-entrypoint.sh elasticsearch