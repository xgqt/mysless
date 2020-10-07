#!/bin//sh


trap 'exit 128' INT
export PATH

set -e


sh ./shellcheck.sh
sh ./dev.sh -c

git add .
git commit -m "${*}"
git push
