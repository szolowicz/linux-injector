#!/usr/bin/env bash

processid=$(pidof $1)

inject="$(
pkexec env gdb -n -q -batch \
  -ex "attach $processid" \
  -ex "set \$dlopen = (void*(*)(char*, int)) dlopen" \
  -ex "call \$dlopen(\"$2\", 1)" \
  -ex "detach" \
  -ex "quit"
)"