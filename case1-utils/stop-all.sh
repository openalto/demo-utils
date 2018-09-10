#!/bin/bash

sudo pkill gunicorn
sudo pkill xdom-mn
docker stop unicorn1
