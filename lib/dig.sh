#!/bin/bash

dig any _kerberos._tcp.`cat tmp/tempfile`| grep 'AUTHORITY SECTION' -A 1| awk 'NR==2{print ($5)}'