#!/bin/bash
# chkconfig: 345 70 30

# Source function library.
. /etc/init.d/functions

RETVAL=0
PROG="/usr/local/bin/mailcatcher"
PATTERN="/usr/local/bin/ruby /usr/local/bin/mailcatcher"

start() {
    echo -n "Starting $PROG: "
    if pgrep -f "$PATTERN" > /dev/null
    then
        echo "already running."
        exit
    fi
    $PROG
    return $?
}

stop() {
    echo -n "Shutting down $PROG: "
    if pgrep -f "$PATTERN" > /dev/null
    then
        kill $(pgrep -f "$PATTERN")
        RETVAL=$?
        [ $RETVAL -eq 0 ] && echo "done."
        return $RETVAL
    else
        echo "already stopped."
        exit
    fi
}

status() {
    echo -n "Checking $PROG status: "
    if pgrep -f "$PATTERN" > /dev/null
    then
        echo "running."
    else
        echo "stopped."
    fi
    return $?
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo "Usage: $PROG {start|stop|status|restart}"
        exit 1
        ;;
esac
exit $RETVAL
