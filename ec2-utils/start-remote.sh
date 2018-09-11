CASE=${1:-case3}

case $CASE in
  case1)
    ssh -t -o StrictHostKeyChecking=no ubuntu@unicorn1 bash ~/start-node.sh
    ;;
  case2)
    ssh -t -o StrictHostKeyChecking=no ubuntu@unicorn1 bash ~/start-node.sh
    ;;
  case3)
    ssh -t -o StrictHostKeyChecking=no ubuntu@unicorn1 bash ~/start-node.sh
    ssh -t -o StrictHostKeyChecking=no ubuntu@unicorn2 bash ~/start-node.sh
    ssh -t -o StrictHostKeyChecking=no ubuntu@unicorn3 bash ~/start-node.sh
    ;;
  case4)
    ssh -t -o StrictHostKeyChecking=no ubuntu@unicorn1 bash ~/start-node.sh
    ssh -t -o StrictHostKeyChecking=no ubuntu@unicorn2 bash ~/start-node.sh
    ssh -t -o StrictHostKeyChecking=no ubuntu@unicorn3 bash ~/start-node.sh
    ;;
  *)
    echo "Support option: {case1|case2|case3|case4}"
    exit 1
esac
