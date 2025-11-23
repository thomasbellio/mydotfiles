if which virtualenvwrapper.sh &>/dev/null; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/code
    source virtualenvwrapper.sh
fi

