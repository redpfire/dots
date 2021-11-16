#!/bin/sh

# $1 = app name

git config --local http.sslCAInfo "`tsh app config --format=ca $1`"
git config --local http.sslCert "`tsh app config --format=cert $1`"
git config --local http.sslKey "`tsh app config --format=key $1`"
git config --local http.sslVerify false
