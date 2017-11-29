#!/bin/bash

RPS_HOME='/home/pi/RetroPie-Setup/'
if [ ! -z "$1" ];then
    echo $1
fi
cp -R scriptmodules/* $RPS_HOME
