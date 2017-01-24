# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

.PHONY: kernel kernel_menuconfig kernel_defconfig

INTERMEDIATE_DIR := ${PLIOS_OUT}/intermediate/kernel

kernel: ${PLIOS_OUT}/intermediate/.kernel_built

kernel_menuconfig: ${INTERMEDIATE_DIR}
	@cd ${INTERMEDIATE_DIR} && make menuconfig
	@cd ${INTERMEDIATE_DIR} && cp .config ${PLIOS_KERNEL_CONFIG}

kernel_defconfig: ${INTERMEDIATE_DIR}
	@cd ${INTERMEDIATE_DIR} && make defconfig
	@cd ${INTERMEDIATE_DIR} && cp .config ${PLIOS_KERNEL_CONFIG}

${PLIOS_OUT}/intermediate/.kernel_built: ${PLIOS_TOOLCHAIN_C} ${INTERMEDIATE_DIR} ${PLIOS_KERNEL_CONFIG}
	@cp ${PLIOS_KERNEL_CONFIG} ${INTERMEDIATE_DIR}/.config
	@echo "===> Building kernel"
	@cd ${INTERMEDIATE_DIR} && make ARCH=${PLIOS_ARCH} CROSS_COMPILE=${CROSS_COMPILE}
	@echo "===> Installing kernel headers"
	@cd ${INTERMEDIATE_DIR} && make ARCH=${PLIOS_ARCH} INSTALL_HDR_PATH=${PLIOS_OUT}/staging/usr headers_install
	@echo "===> Installing kernel modules"
	@cd ${INTERMEDIATE_DIR} && make ARCH=${PLIOS_ARCH} INSTALL_MOD_PATH=${PLIOS_OUT}/staging modules_install
	@touch ${PLIOS_OUT}/intermediate/.kernel_built

${INTERMEDIATE_DIR}: ${PLIOS_OUT}/dl/${PLIOS_KERNEL_TARBALL}
	@mkdir -p ${PLIOS_OUT}/intermediate
	@echo "===> Extracting kernel"
	@tar -xf ${PLIOS_OUT}/dl/${PLIOS_KERNEL_TARBALL} -C ${PLIOS_OUT}/intermediate
	@mv ${PLIOS_OUT}/intermediate/${PLIOS_KERNEL_DIRECTORY} ${INTERMEDIATE_DIR}

${PLIOS_OUT}/dl/${PLIOS_KERNEL_TARBALL}:
	@mkdir -p ${PLIOS_OUT}/dl
	@echo "===> Downloading kernel"
	@cd ${PLIOS_OUT}/dl && curl -LO --progress-bar ${PLIOS_KERNEL_TARBALL_URL}
