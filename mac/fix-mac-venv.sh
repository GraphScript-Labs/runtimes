#!/bin/bash

chmod 777 ./pyvenv.cfg
cat > ./pyvenv.cfg << EOF
home = ./bin
include-system-site-packages = false
version = 3.13.5
executable = ./bin/python3.13
EOF

