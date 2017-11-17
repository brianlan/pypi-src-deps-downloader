#!/usr/bin/env bash

ARCHIVE_NAME="pip_archive"

if [ $# -lt 2 ]
  then
    echo "Invalid number of arguments. Usage: download.sh <python_package_name> <python_version>(2|2.7|2.7.14|3|3.5.2|3.6|...) [in_china]"
    exit 1
fi

PACKAGE=$1; shift;
PY_VER=$1; shift;
IN_CHINA=$1; shift;

echo "=== start to build docker image ==="
docker build -t tmp_img --build-arg python_version=${PY_VER} .

if [ "$IN_CHINA" == "in_china" ]
  then
    douban_pypi="-i https://pypi.douban.com/simple"
  else
    douban_pypi=""
fi

if [ $? -eq 0 ]
  then
    echo "=== start to download python packages and then put them into a tar.gz file ==="
    docker run --rm -v tmp_vol:/${ARCHIVE_NAME} -v $(pwd):/__tmp__ tmp_img \
      bash -c "pip download ${douban_pypi} ${PACKAGE} --dest /${ARCHIVE_NAME}; tar czvf /__tmp__/${ARCHIVE_NAME}.tar.gz /${ARCHIVE_NAME}"

    echo "=== generate install.sh ==="
    echo "tar zxvf ./${ARCHIVE_NAME}.tar.gz" > $(pwd)/install.sh
    echo "pip install ./${ARCHIVE_NAME}/*" >> $(pwd)/install.sh
    chmod +x $(pwd)/install.sh
    zip -r -m ${PACKAGE}.zip install.sh ${ARCHIVE_NAME}.tar.gz
  else
    echo "=== Error found during building docker image. Process aborted and wait for cleaning. ==="
fi

echo "=== deleting temp docker volume ==="
docker volume rm tmp_vol

echo "=== deleting temp docker image ==="
docker rmi tmp_img
