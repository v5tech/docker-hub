# ELK

安装ik分词器

```bash
docker-compose exec elasticsearch elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.15.2/elasticsearch-analysis-ik-7.15.2.zip

docker-compose restart elasticsearch
```