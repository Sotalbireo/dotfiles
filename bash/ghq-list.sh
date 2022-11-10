#!/usr/bin/env bash

function ghq-list() {
  local selected_file=$(ghq list --full-path | peco --prompt="repositories >" --query "$LBUFFER")
  if [ -n "$selected_file" ]; then
    if [ -t 1 ]; then
      cd ${selected_file}
      pwd
    fi
  fi
}
