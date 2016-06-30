#!/bin/bash

if [[ ! -z "$@" ]]; then
  . $HOME/.bashrc
  dcos "$@"
else
  bash -i
fi
