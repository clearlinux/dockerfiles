Elasticsearch
==========
This provides a Clear Linux* Elasticsearch instance.

Build
-----
```
docker build -t clearlinux/elasticsearch .
```

Or just pull it from Dockerhub
---------------------------
```
docker pull clearlinux/elasticsearch
```

Start a elasticsearch instance
-----------------------
```
docker run -d -p 9200:9200 -e "discovery.type=single-node" -v esdata:/usr/share/elasticsearch/data clearlinux/elasticsearch
```

Check cluster health
---------------------
```
curl http://localhost:9200/_cluster/health?pretty
```

Create an index called customer
---------------------
```
curl -X PUT "localhost:9200/customer?pretty"
```

Add new document to that index
---------------------
```
curl -X PUT "localhost:9200/customer/doc/1?pretty" -H 'Content-Type: application/json' -d'{"name": "Tom John" }'
curl -X PUT "localhost:9200/customer/doc/2?pretty" -H 'Content-Type: application/json' -d'{"name": "Kelly Wong" }'
```

View documents in the index
---------------------
```
curl localhost:9200/customer/_search?pretty
```

Details of how-to
---------------------
Please refer to [page](https://www.elastic.co/guide/en/elasticsearch/reference/6.7/docker.html).

Extra Build ARGs
----------------
- ``swupd_args`` Specifies [SWUPD](https://clearlinux.org/documentation/swupdate_how_to_run_the_updater.html) flags

Default build args in Docker are on: https://docs.docker.com/engine/reference/builder/#arg
