#!/bin/bash
#----------------------------
# check raid array
#-------------------------------
# set read-ahead in 512 byte/block per unit
# blockdev --setra 65536 /dev/mdX
#set stripe size cache in 1024*units
# echo 16384 > /sys/block/md0/md/stripe_cache_size

echo check >/sys/block/md0/md/sync_action
