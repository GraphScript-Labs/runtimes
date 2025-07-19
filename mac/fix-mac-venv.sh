#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"
RUNTIME_DIR="$DIR/../runtime"
PYVENV_FILE="$RUNTIME_DIR/pyvenv.cfg"
ACTIVATE_FILE="$RUNTIME_DIR/bin/activate"

mkdir -p "$RUNTIME_DIR/bin"

cat > "$PYVENV_FILE" << EOF
home = $RUNTIME_DIR/bin
include-system-site-packages = false
version = 3.13.5
executable = $RUNTIME_DIR/bin/python3.13
EOF

cat > "$ACTIVATE_FILE" << 'EOF'
# This file must be sourced. You cannot run it directly.

deactivate () {
    if [ -n "$_OLD_VIRTUAL_PATH" ] ; then
        PATH="$_OLD_VIRTUAL_PATH"
        export PATH
        unset _OLD_VIRTUAL_PATH
    fi

    if [ -n "$_OLD_VIRTUAL_PS1" ] ; then
        PS1="$_OLD_VIRTUAL_PS1"
        export PS1
        unset _OLD_VIRTUAL_PS1
    fi

    unset VIRTUAL_ENV
    if [ ! "$1" = "nondestructive" ] ; then
        unset -f deactivate
    fi
}

VIRTUAL_ENV="$(cd "$(dirname "${BASH_SOURCE:-$0}")/.." && pwd)"
export VIRTUAL_ENV

_OLD_VIRTUAL_PATH="$PATH"
PATH="$VIRTUAL_ENV/bin:$PATH"
export PATH

if [ -z "${VIRTUAL_ENV_DISABLE_PROMPT:-}" ] ; then
    _OLD_VIRTUAL_PS1="$PS1"
    PS1="($(basename "$VIRTUAL_ENV")) $PS1"
    export PS1
fi
EOF

