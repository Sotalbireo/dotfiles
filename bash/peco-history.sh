#!/usr/bin/env bash

function peco-history() {
  SELECTED_COMMAND=$(tail -r ~/.bash_history | peco)
  if [ "$SELECTED_COMMAND" != "" ]; then
    echo "exec: ${SELECTED_COMMAND}"
    eval $SELECTED_COMMAND
    history -s $SELECTED_COMMAND
  fi
}
