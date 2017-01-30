# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

PLIOS_ARCH := x86_64

PLIOS_KERNEL_REPO := pliOS/kernel_pc_bios

.PHONY: fsimage

fsimage: sysroot
	@mkdir -p ${PLIOS_OUT}/intermediate/isoroot/boot/grub
	@cp ${PLIOS_ROOT}/boards/pc_bios/grub.cfg ${PLIOS_OUT}/intermediate/isoroot/boot/grub
	@cp ${PLIOS_OUT}/intermediate/vmlinuz ${PLIOS_OUT}/intermediate/isoroot/boot
	@grub-mkrescue ${PLIOS_OUT}/intermediate/isoroot -o ${PLIOS_OUT}/fsimage.iso
