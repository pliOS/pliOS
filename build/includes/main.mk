# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

.PHONY: all

all: toolchain

INCLUDE_DIR := ${PLIOS_ROOT}/build/includes

export PATH := ${PLIOS_ROOT}/build/scripts:${PATH}
export PATH := ${PLIOS_OUT}/toolchain/c/bin:${PATH}
export PATH := ${PLIOS_OUT}/toolchain/go/root/bin:${PATH}

export GOROOT := ${PLIOS_OUT}/toolchain/go/root
export GOPATH := ${PLIOS_OUT}/toolchain/go/path

include ${INCLUDE_DIR}/boards/${PLIOS_BOARD}.mk
include ${INCLUDE_DIR}/arch/${PLIOS_ARCH}.mk
include ${INCLUDE_DIR}/toolchain.mk
