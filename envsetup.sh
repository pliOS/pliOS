# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

export PLIOS_ROOT=$(pwd)

export PATH=${PLIOS_ROOT}/pliOS/scripts/utilities:$PATH

export PATH=${PLIOS_ROOT}/out/toolchain/c/bin:$PATH
export PATH=${PLIOS_ROOT}/out/toolchain/go/root/bin:$PATH

export GOROOT=${PLIOS_ROOT}/out/toolchain/go/root
export GOPATH=${PLIOS_ROOT}/out/toolchain/go/path

if [ -f ${PLIOS_ROOT}/settings ]; then
    source ${PLIOS_ROOT}/settings
fi

setup() {
    if [ -f ${PLIOS_ROOT}/settings ];
    then
       echo "Error - already configured. Please delete ${PLIOS_ROOT}/settings to reconfigure."
       return 1
    fi

    local BOARDS="pc_bios"
    local SPINS="desktop"
    local BUILD_TYPES="debug prod"

    local PS3="Board: "

    select BOARD in ${BOARDS};
    do
        if [ -z "${BOARD}" ];
        then
            echo "Please enter a valid choice"
        else
            break
        fi
    done

    local PS3="Spin: "

    select SPIN in ${SPINS};
    do
        if [ -z "${SPIN}" ];
        then
            echo "Please enter a valid choice"
        else
            break
        fi
    done

    local PS3="Build type: "

    select BUILD_TYPE in ${BUILD_TYPES};
    do
        if [ -z "${BUILD_TYPE}" ];
        then
            echo "Please enter a valid choice"
        else
            break
        fi
    done

    while true; do
        read -p "Do you want to build the toolchain? [n] " yn
        case $yn in
            [Yy]* ) local BUILD_TOOLCHAIN=y; break;;
            * ) local BUILD_TOOLCHAIN=n; break;;
        esac
    done

    while true; do
        read -p "Do you want to build the BSP? [n] " yn
        case $yn in
            [Yy]* ) local BUILD_BSP=y; break;;
            * ) local BUILD_BSP=n; break;;
        esac
    done

    while true; do
        read -p "Do you want to build the HAL? [n] " yn
        case $yn in
            [Yy]* ) local BUILD_HAL=y; break;;
            * ) local BUILD_HAL=n; break;;
        esac
    done

    while true; do
        read -p "Do you want to build the core system? [n] " yn
        case $yn in
            [Yy]* ) local BUILD_CORE=y; break;;
            * ) local BUILD_CORE=n; break;;
        esac
    done

    while true; do
        read -p "Do you want to build the spin? [n] " yn
        case $yn in
            [Yy]* ) local BUILD_SPIN=y; break;;
            * ) local BUILD_SPIN=n; break;;
        esac
    done

    echo "Building ${SPIN} ${BUILD_TYPE} build for ${BOARD}"

    if [ ${BUILD_TOOLCHAIN} = "y" ]; then
        echo "Building toolchain from source"
    fi

    if [ ${BUILD_BSP} = "y" ]; then
        echo "Building BSP from source"
    fi

    if [ ${BUILD_HAL} = "y" ]; then
        echo "Building HAL from source"
    fi

    if [ ${BUILD_CORE} = "y" ]; then
        echo "Building core system from source"
    fi

    if [ ${BUILD_SPIN} = "y" ]; then
        echo "Building spin from source"
    fi

    tee >${PLIOS_ROOT}/settings <<EOL
. ${PLIOS_ROOT}/pliOS/scripts/boards/${BOARD}
. ${PLIOS_ROOT}/pliOS/scripts/spins/${SPIN}

BUILD_TOOLCHAIN=${BUILD_TOOLCHAIN}
BUILD_BSP=${BUILD_BSP}
BUILD_HAL=${BUILD_HAL}
BUILD_CORE=${BUILD_CORE}
BUILD_SPIN=${BUILD_SPIN}
EOL

    . ${PLIOS_ROOT}/pliOS/envsetup.sh

    tee >${PLIOS_ROOT}/Makefile <<EOL
PLIOS_ROOT := ${PLIOS_ROOT}

PLIOS_BOARD := ${BOARD}
PLIOS_SPIN := ${SPIN}

BUILD_TOOLCHAIN := ${BUILD_TOOLCHAIN}
BUILD_BSP := ${BUILD_BSP}
BUILD_HAL := ${BUILD_HAL}
BUILD_CORE := ${BUILD_CORE}
BUILD_SPIN := ${BUILD_SPIN}

include \$(PLIOS_ROOT)/plios/includes/main.mk
EOL
}
