#!/usr/bin/env bash

# Execute the apache daemon in the foreground so we can treat the container as an
# executeable and it wont immediately return.
/usr/sbin/apache2 -D FOREGROUND