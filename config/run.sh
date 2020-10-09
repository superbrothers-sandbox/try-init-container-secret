#!/usr/bin/env bash

set -x

SECRET="my-app"

while true; do
  if kubectl get secret "$SECRET"; then
    echo "${SECRET} secret already exists."
    exit 0
  fi

  PASS="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"
  kubectl create secret generic "$SECRET" --from-literal="PASS=$PASS"
  if [[ "$?" == 0 ]]; then
    exit 0
  fi

  echo "failed to create a ${SECRET} secret, retry 1 sec later"
  sleep 1
done
# vim: ai ts=2 sw=2 et sts=2 ft=sh
