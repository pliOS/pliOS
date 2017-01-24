# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

PLIOS_GO_TARBALL := go1.7.4.linux-amd64.tar.gz
PLIOS_GO_TARBALL_URL := https://storage.googleapis.com/golang/${PLIOS_GO_TARBALL}

.PHONY: toolchain toolchain_c toolchain_go

toolchain: toolchain_c toolchain_go

toolchain_go: ${PLIOS_OUT}/toolchain/go

${PLIOS_OUT}/toolchain/go: ${PLIOS_OUT}/dl/${PLIOS_GO_TARBALL}
	@mkdir -p ${PLIOS_OUT}/toolchain/go/path
	@echo "===> Extracting golang"
	@tar -xf ${PLIOS_OUT}/dl/${PLIOS_GO_TARBALL} -C ${PLIOS_OUT}/toolchain/go
	@mv ${PLIOS_OUT}/toolchain/go/go ${PLIOS_OUT}/toolchain/go/root

${PLIOS_OUT}/dl/${PLIOS_GO_TARBALL}:
	@mkdir -p ${PLIOS_OUT}/dl
	@echo "===> Downloading golang"
	@cd ${PLIOS_OUT}/dl && curl -LO --progress-bar ${PLIOS_GO_TARBALL_URL}

CURRENT_DIRECTORY := ${PLIOS_ROOT}/toolchains
-include ${PLIOS_ROOT}/toolchains/pliOS.mk
