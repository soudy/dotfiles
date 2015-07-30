#!/bin/bash
#TIME=$(clock -f '⭧ %a %I: %M')
TIME=$(date "+%A %b %d %H:%M")

echo "S%{F#FFffffff}%{F-} ${TIME}"
