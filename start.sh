#!/bin/bash

set -e

domain=witmob.com
sub_domain=chat

ssh root@$sub_domain.$domain -t "docker compose up -d"