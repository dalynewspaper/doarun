#!/bin/bash

if [[ $# -lt 2 || ($1 != "web" && $1 != "android") || ($2 != "beta" && $2 != "production") ]]
then
  printf "Please pass 'web' or 'android' as a first argument and 'beta' or 'production' as a second argument.\n"
elif [[ $2 == "production" ]]
then
  printf "Production flavor is not available yet.\n"
elif [[ $1 == "web" ]]
then
  rm ./web/index.html
  cp ./web/flavors/index_"$2".html ./web
  mv ./web/index_"$2".html ./web/index.html
  flutter build web -t ./lib/main_"$2".dart
elif [[ $1 == "android" ]]
then
  rm ./android/app/src/main/AndroidManifest.xml
  cp ./android/flavors/AndroidManifest_"$2".xml ./android/app/src/main/
  mv ./android/app/src/main/AndroidManifest_"$2".xml ./android/app/src/main/AndroidManifest.xml
  flutter build apk --flavor "$2" -t ./lib/main_"$2".dart
fi