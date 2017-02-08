# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

PLIOS_ARCH := x86_64

PLIOS_KERNEL_REPO := pliOS/kernel_pc_bios

.PHONY: fsimage

fsimage: sysroot
	@echo "===> Making fs image"
	@sudo mkdir -p ${PLIOS_OUT}/rootfs/sbin
	@sudo mkdir -p ${PLIOS_OUT}/rootfs/bin
	@sudo mkdir -p ${PLIOS_OUT}/rootfs/proc
	@sudo mkdir -p ${PLIOS_OUT}/rootfs/sys
	@sudo mkdir -p ${PLIOS_OUT}/rootfs/dev
	@sudo mkdir -p ${PLIOS_OUT}/rootfs/run
	@sudo cp -R ${PLIOS_ROOT}/rootfs/. ${PLIOS_OUT}/rootfs
	@sudo virt-make-fs -t ext4 ${PLIOS_OUT}/rootfs ${PLIOS_OUT}/bin/rootfs.img
