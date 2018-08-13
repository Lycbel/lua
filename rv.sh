#!/bin/sh
# This is running under Ubuntu 16.04
# Install necessary packages. 
sudo apt-get install -y libreadline-dev

VERSION=5.3.4
tar_tests=lua-$VERSION-tests.tar.gz
wget https://www.lua.org/tests/$tar_tests
tar -xvz $tar_tests

json_out=my_errors.json
compiler=kcc
reportflag="CFLAGS=-fissue-report=$json_out"
sudo make -j`nproc` linux CC=$compiler LD=$compiler $reportflag 

cd lua-$VERSION-tests/
../lua all.lua

# Generate a HTML report with `rv-html-report` command,
# and output the HTML report to `./report` directory. 
rv-html-report my_errors.json -o report

# Upload your HTML report to RV-Toolkit website with `rv-upload-report` command. 
rv-upload-report `pwd`/report

# Done.