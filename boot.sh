#!/bin/sh
source venv/bin/activate
source export.sh

while true; do
	flask deploy
	echo $?
	if [ $? == 0 ]; then
		break
	fi
	echo Deploy command failed, retrying in 5 secs...
	sleep 5
done

exec gunicorn -b 0.0.0.0:5000 --access-logfile - --error-logfile - flasky:app
