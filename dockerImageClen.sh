#!/bin/bash
#Auther: guinan34

#clean up all images but keep every recently 2 versions of the same component
for i in `docker images|sed '1d' |awk '{print $1}'|awk -F \/ '{print $2}'|grep -v '^$'|sort -u`
  do
    DELLIST=`docker images |grep $i|sed "1,2d"|awk '{print $3}'`
    #echo $DELLIST
    echo "The current component is  $i"
    if [ ! -n "$DELLIST" ];then
      echo 'Keep recently 2 versions, will not clean.'
      docker images |grep $i|awk '{print $1"  "$2}'
      echo -e \\n
    else
      echo 'More than 2 versions, start clean'
      docker images |grep $i|awk '{print $1"  "$2}'
      docker rmi $DELLIST -f
      echo -e \\n
    fi
  done
