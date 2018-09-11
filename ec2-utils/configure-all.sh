#!/bin/bash

CASE=${1:-case3}

PYUNICORN_PATH=${PYUNICORN_PATH:-$HOME}

pyunicorn_run() {
  id=$1
  path_json=$2
  $PYUNICORN_PATH/pyunicorn -e http://unicorn$id:8181 --data "$(cat $(pwd)/config_$id/$path_json)" setup_path
}

case $CASE in
  case1)
    ./subscribe-all.sh unicorn1
    ./initialize-path-manager.sh unicorn1
    ./set-bandwidth-all.sh unicorn1
    # Config default routes
    pyunicorn_run 1 case1-path-1.json
    pyunicorn_run 1 case1-path-2.json
    ;;
  case2)
    ./subscribe-all.sh unicorn1
    ./initialize-path-manager.sh unicorn1
    ./set-bandwidth-all.sh unicorn1
    ;;
  case3)
    ./subscribe-all.sh unicorn1
    ./subscribe-all.sh unicorn2
    ./subscribe-all.sh unicorn3
    ./initialize-path-manager.sh unicorn1
    ./initialize-path-manager.sh unicorn2
    ./initialize-path-manager.sh unicorn3
    # Config default routes
    pyunicorn_run 1 path-1.json
    pyunicorn_run 2 path-1.json
    pyunicorn_run 3 path-1.json
    pyunicorn_run 1 path-2.json
    pyunicorn_run 2 path-2.json
    pyunicorn_run 3 path-2.json
    ;;
  case4)
    ./subscribe-all.sh unicorn1
    ./subscribe-all.sh unicorn2
    ./subscribe-all.sh unicorn3
    ./initialize-path-manager.sh unicorn1
    ./initialize-path-manager.sh unicorn2
    ./initialize-path-manager.sh unicorn3
    # Config default routes
    pyunicorn_run 1 path-1.json
    pyunicorn_run 2 path-1.json
    pyunicorn_run 3 path-1.json
    pyunicorn_run 1 path-2.json
    pyunicorn_run 2 path-2.json
    pyunicorn_run 3 path-2.json
    ;;
  *)
    echo "Support option: {case1|case2|case3|case4}"
    exit 1
esac
