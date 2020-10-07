#!/bin//sh


# This file is part of mysless.

# mysless is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# mysless is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with mysless.  If not, see <https://www.gnu.org/licenses/>.


trap 'exit 128' INT
export PATH

set -e


sh ./shellcheck.sh
sh ./dev.sh -c

git add .
git commit -m "${*}"
git push
