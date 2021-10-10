#!/usr/bin/env bash

echo "Hi please input your object"
echo -n "enter your obect:"
read -r object

if [ $object == x ];
then
  echo "your nested object is /y/z/a "
elif [[ $object == x/y ]];
  then
    echo "your nested object is /z/a"
elif [[ $object == x/y/z ]];
  then
    echo "your nested object is a"
else
  echo "you have enterred incorrect object"
fi 

