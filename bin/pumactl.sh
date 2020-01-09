#!/bin/bash

current_dir=`(cd $(dirname $0); pwd)`
rails_root=`(cd "$current_dir/../"; pwd)`

start() {
  echo "starting puma"
  cd $rails_root
  bundle exec pumactl start

  RETVAL=$?
  return $RETVAL
}

stop() {
  echo "stopping puma"
  cd $rails_root
  bundle exec pumactl stop

  RETVAL=$?
  return $RETVAL
}

# See how we were called.
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    stop
    start
    ;;
  *)
    echo $"Usage: $prog {start|stop|restart}"
    exit 1
esac

exit $RETVAL
