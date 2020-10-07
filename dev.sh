#!/bin/sh


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


dirs="
    9base
    dmenu
    dwm
    dwmstatus
    st
"

ins_dir="$(pwd)/image/usr"


case ${1}
in
    -b | --build )
        build=1
        ;;
    -c | --clean )
        build=0
        ;;
    * )
        echo "Usage: [-b | --build] | [-c | --clean]"
        exit 1
        ;;
esac


[ -d "${ins_dir}" ] && rm -rfd "${ins_dir}"
mkdir -p "${ins_dir}"


for d in ${dirs}
do
    cd "${d}" || exit 1

    make clean

    if [ "${build}" -gt 0 ]
    then
        echo ">>> Building: ${d}"
        make -j"$(nproc)" || exit 1
        make PREFIX="${ins_dir}" install || exit 1
        echo ">>> Buit: ${d}"
    else
        echo ">>> Cleaned: ${d}"
    fi

    cd - >/dev/null || exit 1
done
