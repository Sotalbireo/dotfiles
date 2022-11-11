#!/usr/bin/env bash

function peco-history() {
  history -n
  BUFFER=$(history | tac | sed -r 's/^\s*?[0-9]+\s?*//' | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
}
