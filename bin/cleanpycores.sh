#!/bin/bash
find  /home/ppatel/ -name "core-python*" -type f | xargs -r rm
find  /home/ppatel/ -name "core-vim-*" -type f | xargs -r rm
find  /home/ppatel/ -name "core-gdb-*" -type f | xargs -r rm
find  /home/ppatel/ -name "core-controller_d-*" -type f | xargs -r rm
find  /home/ppatel/ -name "core-ctags-*" -type f | xargs -r rm
