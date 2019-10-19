#!/usr/bin/awk
$3 > 0 { printf "%s #%d: %s %s %s", FILENAME, NR, $1, $2, $3 }
