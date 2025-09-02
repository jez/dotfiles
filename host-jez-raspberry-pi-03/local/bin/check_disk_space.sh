#!/usr/bin/env bash

set -euo pipefail

# Sample:
# Use%
#  10%
sd_card_used=$(df --output='pcent' /dev/mmcblk0p2 | tail -n +2 | sed -e 's/%//')
if ((sd_card_used < 75)); then
  echo "Plenty of disk space left: only ${sd_card_used}% used"
  exit
fi

echo "Low disk space: ${sd_card_used}% used"

if ! command -v dust &> /dev/null; then
  export PATH="$PATH:$HOME/.local/bin"
fi

message="$(mktemp)"
trap "rm -f '$message'" EXIT
> "$message" cat <<EOF
Content-Type: text/html
Subject: [raspi] SD card using ${sd_card_used}% of available

<p>Probably time to poke at it and see what's up.</p>

<pre><code>
EOF
>> "$message" df -h
>> "$message" echo '</code></pre><pre><code>'
>> "$message" dust /
>> "$message" echo '</code></pre>'

msmtp "zimmerman.jake@gmail.com" < "$message"
