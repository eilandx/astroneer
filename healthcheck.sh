#!/bin/sh

#!/bin/sh
if pgrep -x "Shipping.exe" > /dev/null
then
  exit 0
else
  exit 1
fi