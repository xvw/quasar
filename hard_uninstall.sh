#!/bin/bash
lib=`opam config var lib`
boot="$lib/quasar"
echo "erase [quasar] localised in [$boot]"
rm -r $boot
