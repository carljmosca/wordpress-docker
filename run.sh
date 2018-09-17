#!/bin/bash

docker stop wp
docker rm wp
docker run -d --name=wp \
    --user=100001:0 \
    -p 80:8080 -p 443:8443 \
    -e HOSTNAME=test.colonybythesea.net \
    carljmosca/wp:4.9.8