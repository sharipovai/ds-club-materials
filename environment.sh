#!/bin/sh

if [ "${BASH_SOURCE-}" = "$0" ]; then
    echo "You must source this script: source $0" >&2
    exit 33
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" &> /dev/null && pwd )

INSTALL_PATH="$SCRIPT_DIR/miniconda3"
MINICONDA="$SCRIPT_DIR/miniconda3/bin"
LOAD_SCRIPT="$SCRIPT_DIR/Miniconda3-py37_23.1.0-1-MacOSX-x86_64.sh"
DL_LINK="https://repo.anaconda.com/miniconda/Miniconda3-py37_23.1.0-1-MacOSX-x86_64.sh"



echo "Check for update environment $INSTALL_PATH" # основной интерпретатор

if which python | grep --silent "$MINICONDA\0"; then
    echo "good python version :)"
else
    if [ ! -f $LOAD_SCRIPT ]; then
        curl -Lo $LOAD_SCRIPT $DL_LINK; fi # скачиваем скрипт загрузки миниконды
    echo "Script is uploaded"
    if ! echo $PATH | grep --silent $MINICONDA; then
        export PATH=$MINICONDA:$PATH; fi
    export MINICONDA=$INSTALL_PATH # добавляем в переменные окружения при необходимости
    if [ ! -d $MINICONDA ]; then
        sh $LOAD_SCRIPT -b -p $INSTALL_PATH; # используем скрипт для установки миниконды в папку проекта
        conda init --all;
        exit; fi
    echo "Conda is installed"
fi
