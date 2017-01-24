# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

export CROSS_COMPILE := x86_64-amd-linux-gnu-
export GOOS := linux
export GOARCH := amd64

PLIOS_TOOLCHAIN_DIR := amd-2016.11
PLIOS_TOOLCHAIN_TARBALL:= amd-2016.11-19-x86_64-amd-linux-gnu-i686-pc-linux-gnu.tar.bz2
PLIOS_TOOLCHAIN_BASEURL := https://sourcery.mentor.com/GNUToolchain/package14747/public/x86_64-amd-linux-gnu/
PLIOS_TOOLCHAIN_URL := ${PLIOS_TOOLCHAIN_BASEURL}${PLIOS_TOOLCHAIN_TARBALL}

PLIOS_TOOLCHAIN_C := ${PLIOS_OUT}/toolchain/c ${PLIOS_OUT}/staging/lib64/ld-linux-x86-64.so.2

${PLIOS_OUT}/staging/lib64/ld-linux-x86-64.so.2:
	@mkdir -p ${PLIOS_OUT}/staging
	@echo "===> Installing toolchain"
	@cp -R ${PLIOS_OUT}/toolchain/c/x86_64-amd-linux-gnu/libc/lib64 ${PLIOS_OUT}/staging
	@cp -R ${PLIOS_OUT}/toolchain/c/x86_64-amd-linux-gnu/libc/sbin ${PLIOS_OUT}/staging
	@cp -R ${PLIOS_OUT}/toolchain/c/x86_64-amd-linux-gnu/libc/usr ${PLIOS_OUT}/staging

${PLIOS_OUT}/toolchain/c: ${PLIOS_OUT}/dl/$(PLIOS_TOOLCHAIN_TARBALL)
	@mkdir -p ${PLIOS_OUT}/toolchain
	@echo "===> Extracting toolchain"
	@tar -xf ${PLIOS_OUT}/dl/$(PLIOS_TOOLCHAIN_TARBALL) -C ${PLIOS_OUT}/toolchain
	@mv ${PLIOS_OUT}/toolchain/$(PLIOS_TOOLCHAIN_DIR) ${PLIOS_OUT}/toolchain/c

${PLIOS_OUT}/dl/$(PLIOS_TOOLCHAIN_TARBALL):
	@mkdir -p ${PLIOS_OUT}/dl
	@echo "===> Downloading toolchain"
	@cd ${PLIOS_OUT}/dl && curl -LO --progress-bar $(PLIOS_TOOLCHAIN_URL)
