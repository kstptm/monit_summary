#!/usr/bin/env sh

XML=$(curl --silent "$MONIT_HOST/_status?level=full&format=xml")

echo Host: \
  "$(echo $XML | xmllint --xpath 'string(/monit/server/localhostname)' -)"

echo LA: \
  "$(echo $XML | xmllint --xpath 'string(/monit/service[@type="5"]/system/load/avg01)' -)" \
  "$(echo $XML | xmllint --xpath 'string(/monit/service[@type="5"]/system/load/avg05)' -)" \
  "$(echo $XML | xmllint --xpath 'string(/monit/service[@type="5"]/system/load/avg15)' -)"

echo CPU: \
  "$(echo $XML | xmllint --xpath 'string(/monit/service[@type="5"]/system/cpu/user)' -)"% user, \
  "$(echo $XML | xmllint --xpath 'string(/monit/service[@type="5"]/system/cpu/system)' -)"% system, \
  "$(echo $XML | xmllint --xpath 'string(/monit/service[@type="5"]/system/cpu/user)' -)"% wait

echo Memory: \
  "$(echo $XML | xmllint --xpath 'string(/monit/service[@type="5"]/system/memory/kilobyte)' -)"kb \
  \("$(echo $XML | xmllint --xpath 'string(/monit/service[@type="5"]/system/memory/percent)' -)"%\)

echo Swap: \
  "$(echo $XML | xmllint --xpath 'string(/monit/service[@type="5"]/system/swap/kilobyte)' -)"kb \
  \("$(echo $XML | xmllint --xpath 'string(/monit/service[@type="5"]/system/swap/percent)' -)"%\)

echo Disk: \
  "$(echo $XML | xmllint --xpath 'string(/monit/service[@type="0"]/block/usage)' -)"kb of \
  "$(echo $XML | xmllint --xpath 'string(/monit/service[@type="0"]/block/total)' -)"kb \
  \("$(echo $XML | xmllint --xpath 'string(/monit/service[@type="0"]/block/percent)' -)"%\)
