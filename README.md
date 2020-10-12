# Online Radio Search Mobile

![Build flutter app](https://github.com/mkazinauskas/online-radio-search-mobile/workflows/Build%20flutter%20app/badge.svg?branch=master)

## How to try app
Visit [https://play.google.com/store/apps/details?id=com.modakoda.onlineradiosearchmobile](https://play.google.com/store/apps/details?id=com.modakoda.onlineradiosearchmobile)

## How to generate signing key
* `flutter doctor -v`
* locate java path and replace java with keytool
* `/java-path-from-flutter/keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key`

## How to build app
* Copy `key.properties` file to `android` folder
* Run command `flutter build appbundle`