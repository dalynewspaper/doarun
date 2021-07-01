#!/bin/bash

if [[ $# -lt 2 || ($1 != "web" && $1 != "android") || ($2 != "dev" && $2 != "beta") ]]
then
  printf "Please pass 'web' or 'android' as a first argument and 'dev' or 'beta' as a second argument\n"
elif [[ $1 == "web" ]]
then
  rm ./web/index.html
  cp ./web/flavors/index_"$2".html ./web
  mv ./web/index_"$2".html ./web/index.html
  flutter run -t lib/main_"$2".dart -d chrome --web-port 7357 --flavor "$2"
elif [[ $1 == "android" ]]
then
  rm ./android/app/src/main/AndroidManifest.xml
  cp ./android/flavors/AndroidManifest_"$2".xml ./android/app/src/main/
  mv ./android/app/src/main/AndroidManifest_"$2".xml ./android/app/src/main/AndroidManifest.xml
  flutter run -t lib/main_"$2".dart --flavor "$2"
fi