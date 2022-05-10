#!/bin/bash

# bin/elasticsearch-plugin install analysis-icu
# bin/elasticsearch-plugin install analysis-smartcn
# bin/elasticsearch-plugin install analysis-phonetic
# bin/elasticsearch-plugin install ingest-attachment
# bin/elasticsearch-plugin install --batch https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.15.2/elasticsearch-analysis-ik-7.15.2.zip
# bin/elasticsearch-plugin install --batch https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v7.15.2/elasticsearch-analysis-pinyin-7.15.2.zip
# bin/elasticsearch-plugin install repository-s3

bin/elasticsearch-plugin install --batch file:///apps/elasticsearch-plugin/analysis-icu-7.15.2.zip
bin/elasticsearch-plugin install --batch file:///apps/elasticsearch-plugin/analysis-smartcn-7.15.2.zip
bin/elasticsearch-plugin install --batch file:///apps/elasticsearch-plugin/analysis-phonetic-7.15.2.zip
bin/elasticsearch-plugin install --batch file:///apps/elasticsearch-plugin/ingest-attachment-7.15.2.zip
bin/elasticsearch-plugin install --batch file:///apps/elasticsearch-plugin/elasticsearch-analysis-ik-7.15.2.zip
bin/elasticsearch-plugin install --batch file:///apps/elasticsearch-plugin/elasticsearch-analysis-pinyin-7.15.2.zip
bin/elasticsearch-plugin install --batch file:///apps/elasticsearch-plugin/repository-s3-7.15.2.zip

exec /usr/local/bin/docker-entrypoint.sh elasticsearch