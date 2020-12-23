#!/bin/bash

# ssh start
/usr/sbin/sshd -D

# rstudio server start
rstudio-server start

# vscode start
/vscode/code-server --port 8989

/bin/bash