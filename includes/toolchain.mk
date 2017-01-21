# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

ifeq ($(BUILD_TOOLCHAIN), y)
	PLIOS_TOOLCHAIN_TARBALL := out/build/tarballs/$(PLIOS_TOOLCHAIN)
else
	PLIOS_TOOLCHAIN_TARBALL := out/tarballs/$(PLIOS_TOOLCHAIN)
endif

PLIOS_GO_TARBALL := go1.7.4.linux-amd64.tar.gz
PLIOS_GO_TARBALL_URL := https://storage.googleapis.com/golang/$(PLIOS_GO_TARBALL)

.PHONY: toolchain toolchain_c toolchain_go

toolchain: toolchain_c toolchain_go

toolchain_c: $(PLIOS_TOOLCHAIN_TARBALL).tar.gz
	@mkdir -p out/toolchain
	@tar -xf $(PLIOS_TOOLCHAIN_TARBALL).tar.gz -C out/toolchain
	@mv out/toolchain/$(PLIOS_ARCH) out/toolchain/c

toolchain_go: out/tarballs/$(PLIOS_GO_TARBALL)
	@mkdir -p out/toolchain/go/path
	@tar -xf out/tarballs/$(PLIOS_GO_TARBALL) -C out/toolchain/go
	@mv out/toolchain/go/go out/toolchain/go/root

out/tarballs/$(PLIOS_GO_TARBALL):
	@mkdir -p out/tarballs
	@cd out/tarballs && curl -LO --progress-bar $(PLIOS_GO_TARBALL_URL)

out/tarballs/$(PLIOS_TOOLCHAIN).tar.gz:
	@mkdir -p out/tarballs
	@cd out/tarballs && download_release.sh pliOS/toolchains $(PLIOS_TOOLCHAIN)

CURRENT_DIRECTORY := $(PLIOS_ROOT)/toolchains
-include $(PLIOS_ROOT)/toolchains/pliOS.mk
