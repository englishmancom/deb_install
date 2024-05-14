#!/bin/bash
#----------------------------
# scrub periodico ZFS
#-------------------------------
# occhio che il test non viene effettuato sulle pool/file-system
# con checksum=off
zpool scrub tank
