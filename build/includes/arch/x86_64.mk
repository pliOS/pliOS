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

toolchain_c: out/toolchain/c out/staging/lib64/ld-linux-x86-64.so.2

out/staging/lib64/ld-linux-x86-64.so.2:
	@mkdir -p out/staging
	@echo "===> Installing toolchain"
	@cp -R out/toolchain/c/x86_64-amd-linux-gnu/libc/lib64 out/staging
	@cp -R out/toolchain/c/x86_64-amd-linux-gnu/libc/sbin out/staging
	@cp -R out/toolchain/c/x86_64-amd-linux-gnu/libc/usr out/staging

out/toolchain/c: out/dl/$(PLIOS_TOOLCHAIN_TARBALL)
	@mkdir -p out/toolchain
	@echo "===> Extracting toolchain"
	@tar -xf out/dl/$(PLIOS_TOOLCHAIN_TARBALL) -C out/toolchain
	@mv out/toolchain/$(PLIOS_TOOLCHAIN_DIR) out/toolchain/c

out/dl/$(PLIOS_TOOLCHAIN_TARBALL):
	@mkdir -p out/dl
	@echo "===> Downloading toolchain"
	@cd out/dl && curl -LO --progress-bar $(PLIOS_TOOLCHAIN_URL)
