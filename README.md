# pypi-src-deps-downloader
This tool is aiming at download the python package source from PyPi (including all its dependencies)

__Prerequisite__:
* Docker Engine ([how to install](https://docs.docker.com/engine/installation/))

__Usage__:
```sh
bash download.sh <python_package_name> <python_version>
```
__Example__:
```sh
bash download.sh jupyter 2.7
```
After download.sh is finished, you will get two files: __*pip_archive.tar*__ and __*install.sh*__ in your current folder. Copy those files to your destination machine and run below command to install all the dependent python packages.
```sh
bash install.sh
```
