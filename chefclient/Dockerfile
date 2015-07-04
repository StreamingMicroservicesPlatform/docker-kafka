FROM ubuntu:14.04

RUN apt-get -yqq install curl
RUN URL='https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/10.04/x86_64/chef_12.4.0-1_amd64.deb'; FILE=`mktemp`; curl -o $FILE "$URL" && sudo dpkg -i $FILE; rm $FILE
