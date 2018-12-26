#!/bin/bash
. /appenv/bin/activate
##$@ represnts all arguments passed to the script 
##e.g if we pass entrypoint.sh python manage.py test , tehn first the virtual env will be exceuted then the python manage.py test will be excuted in the virtual enviornment 
exec $@
#$@
##while using the exec command the PID from bash is not handed over as new pid and carry forwarded as the same pid 
##so that when the docker container is stopped the application does a gracefull stop 
