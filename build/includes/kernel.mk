# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

.PHONY: kernel

kernel: ${PLIOS_OUT}/bin/vmlinuz

${PLIOS_OUT}/bin/vmlinuz:
	@mkdir -p ${PLIOS_OUT}/bin
	@echo "===> Downloading kernel"
	@cd ${PLIOS_OUT}/bin && download_release.sh $(PLIOS_KERNEL_REPO) vmlinuz
