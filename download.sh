#!/usr/bin/env bash

if [ $# -ne 1 ]
  then
    echo "Invalid number of arguments. Usage: download.sh <python_package_name>"
    exit 1
fi

PACKAGE=$1; shift;

echo "start to build docker image"
docker build -t tmp_img .

echo "start to download python packages and then put them into a tar.gz file"
docker run --rm -v tmp_vol:/__packages__ -v $(pwd):/__tmp__ tmp_img bash -c "pip download --cache-dir /__packages__ ${PACKAGE} ; tar czvf /__tmp__/py_archive.tar.gz /__packages__"

echo "deleting temp docker volume"
docker volume rm tmp_vol

echo "deleting temp docker image"
docker rmi tmp_img
