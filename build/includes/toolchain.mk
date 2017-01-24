# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

PLIOS_GO_TARBALL := go1.7.4.linux-amd64.tar.gz
PLIOS_GO_TARBALL_URL := https://storage.googleapis.com/golang/$(PLIOS_GO_TARBALL)

.PHONY: toolchain toolchain_c toolchain_go

toolchain: toolchain_c toolchain_go

toolchain_go: out/toolchain/go

out/toolchain/go: out/dl/$(PLIOS_GO_TARBALL)
	@mkdir -p out/toolchain/go/path
	@echo "===> Extracting golang"
	@tar -xf out/dl/$(PLIOS_GO_TARBALL) -C out/toolchain/go
	@mv out/toolchain/go/go out/toolchain/go/root

out/dl/$(PLIOS_GO_TARBALL):
	@mkdir -p out/dl
	@echo "===> Downloading golang"
	@cd out/dl && curl -LO --progress-bar $(PLIOS_GO_TARBALL_URL)

CURRENT_DIRECTORY := $(PLIOS_ROOT)/toolchains
-include $(PLIOS_ROOT)/toolchains/pliOS.mk
