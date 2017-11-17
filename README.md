# pypi-src-deps-downloader
This tool is aiming at download the python package source from PyPi (including all its dependencies)

__Prerequisite__:
* Docker Engine ([how to install](https://docs.docker.com/engine/installation/))

__Usage__:
```sh
bash download.sh <python_package_name> <python_version> [in_china]
```
__Example__:
```sh
bash download.sh jupyter 2.7 in_china
```
After download.sh is finished, you will get two files: __*pip_archive.tar*__ and __*install.sh*__ in your current folder. Copy those files to your destination machine and run below command to install all the dependent python packages. If you specify _in_china_ as an input argument, pypi mirror of Douban will be used.
```sh
bash install.sh
```
