#!/bin/bash

if [[ $# -eq 0 ]]
then
  printf "Please pass 'beta' or 'dev' as an argument\n"
else
  if [[ $1 == "dev" ]]
  then
    rm ./web/index.html
    cp ./web/flavors/index_dev.html ./web
    mv ./web/index_dev.html ./web/index.html
  elif [[ $1 == "beta" ]]
  then
    rm ./web/index.html
    cp ./web/flavors/index_beta.html ./web
    mv ./web/index_beta.html ./web/index.html
  fi
  flutter run -t lib/main_"$1".dart -d chrome --web-port 7357 --flavor "$1"
fi