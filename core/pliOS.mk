# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

include ${INCLUDE_DIR}/golang.mk

$(eval $(call GO_BINARY,core/init,rootfs/sbin/init,sysroot))

BUSYBOX_URL := https://busybox.net/downloads/binaries/1.26.2-defconfig-multiarch/busybox-x86_64

sysroot: ${PLIOS_OUT}/rootfs/bin/busybox

${PLIOS_OUT}/rootfs/bin/busybox: ${PLIOS_OUT}/intermediate/busybox-x86_64
	@echo "===> Installing busybox"
	@mkdir -p ${PLIOS_OUT}/rootfs/bin
	@sudo ${PLIOS_OUT}/intermediate/busybox-x86_64 --install ${PLIOS_OUT}/rootfs/bin

${PLIOS_OUT}/intermediate/busybox-x86_64:
	@mkdir -p ${PLIOS_OUT}/intermediate
	@echo "===> Downloading busybox"
	@cd ${PLIOS_OUT}/intermediate && curl -LO --progress-bar ${BUSYBOX_URL}
	@chmod a+x ${PLIOS_OUT}/intermediate/busybox-x86_64
