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

exit_status=0


die() {
    echo "!!! Errors occured !!!"
    echo "Exiting..."
    exit_status=1
    exit 1
}


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


if command -v ts
then
    ts_impl="ts"
else
    ts_impl="busybox ts"
fi

echo "ts implementation: ${ts_impl}"


(
    for d in ${dirs}
    do
        cd "${d}" || die

        make clean

        if [ "${build}" -gt 0 ]
        then
            echo ">>> Building: ${d}"
            make -j"$(nproc)" || die
            make PREFIX="${ins_dir}" install || die
            echo ">>> Buit: ${d}"
        else
            echo ">>> Cleaned: ${d}"
        fi

        cd - >/dev/null || die
    done
) | ${ts_impl} '[ %H:%M:%S ]:'


if [ ${exit_status} -gt 0 ]
then
    exit 1
else
    exit 0
fi
