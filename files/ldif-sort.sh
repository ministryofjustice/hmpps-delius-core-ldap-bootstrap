#!/bin/bash
#
# Usage:
#   cat file | ./ldif-sort.sh
#
# Sorts an LDIF file hierarchically, so entries can be imported in the correct order.
#
# This is done using the following steps:
# 1. Convert line-endings to unix
# 2. Remove any comment lines
# 3. Squash LDIF entry paragraphs into single lines
# 4. Prepend each line with a count of the commas (,) in the dn attribute
# 5. Sort the lines numerically
# 6. Remove the prepended comma counts
# 7. Expand LDIF entries back into paragraphs
#

sed $'s/\r$//' \
| sed '/^#/d' \
| awk 'BEGIN{RS="\n\n" ; ORS="\2";}{ print }' \
| awk 'BEGIN{RS="\n" ; ORS="\1";}{ print }' \
| awk 'BEGIN{RS="\2" ; ORS="\n";}{ print }' \
| awk -F ':' '{ orig = $0; print gsub(/,/, "", $2) " " orig }' \
| sort -n \
| sed 's/[^ ]* //' \
| awk '{$1=$1}1' FS='\1' OFS='\n' ORS='\n\n'
