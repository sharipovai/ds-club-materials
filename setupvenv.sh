#!/bin/sh

if [ "${BASH_SOURCE-}" = "$0" ]; then
    echo "You must source this script: source $0" >&2
    exit 33
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "$0" )" &> /dev/null && pwd )

CONDAVENV="$SCRIPT_DIR/condavenv"



echo "Check for update environment $CONDAVENV" # виртуальное окружение над основным интерпретатором
#
if [ ! -d "$CONDAVENV" ]; then
    conda create -y python=3.7 pip --prefix "$CONDAVENV"; fi
if ! echo $PATH | grep --silent ^"$CONDAVENV/bin"; then
    conda activate --stack "$CONDAVENV"; fi
pip install jupyter numpy pandas matplotlib seaborn jupyterlab ipykernel jupyter-lsp jupyterlab-lsp python-language-server jedi==0.17.2 plotly;
jupyter labextension install jupyterlab-plotly;
jupyter labextension install @jupyter-widgets/jupyterlab-manager plotlywidget;
ipython kernel install --name "ds-club-kernel" --user;
jupyter lab "$SCRIPT_DIR/linear-regression.ipynb"
