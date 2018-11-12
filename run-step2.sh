WORK_HOME=$HOME

progress-bar() {
  local duration=${1}
    already_done() { for ((done=0; done<$elapsed; done++)); do printf "▇"; done }
    remaining() { for ((remain=$elapsed; remain<$duration; remain++)); do printf " "; done }
    percentage() { printf "| %s%%" $(( (($elapsed)*100)/($duration)*100/100 )); }
    clean_line() { printf "\r"; }

  for (( elapsed=1; elapsed<=$duration; elapsed++ )); do
      already_done; remaining; percentage
      sleep 1
      clean_line
  done
  clean_line
}

echo "Mininet pingall"
$WORK_HOME/Env/unicorn/bin/python $WORK_HOME/demo-utils/tools/mock_zmq.py pingall
progress-bar 10

echo "Configure networks"
./config-all.sh

echo "Starting SFP"
$WORK_HOME/Env/unicorn/bin/gunicorn -b 0.0.0.0:8399 -w 4 sfp:app