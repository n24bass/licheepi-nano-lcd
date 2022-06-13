
################################################################################
#
# boysenboard-flashdrive
#
################################################################################

BOYSENBOARD_FLASHDRIVE_SITE = $(BOYSENBOARD_FLASHDRIVE_PKGDIR)/files
BOYSENBOARD_FLASHDRIVE_SITE_METHOD = local
BOYSENBOARD_FLASHDRIVE_DEPENDENCIES = host-genimage host-dosfstools host-mtools
BOYSENBOARD_FLASHDRIVE_INSTALL_IMAGES = YES
BOYSENBOARD_FLASHDRIVE_INSTALL_TARGET = NO

define BOYSENBOARD_FLASHDRIVE_BUILD_CMDS
	rm -rf "$(@D)/tmp"
	mkdir -p $(@D)/dummyroot
	$(HOST_DIR)/bin/genimage \
		--config $(@D)/genimage.cfg \
		--inputpath $(@D) \
		--outputpath $(@D) \
		--tmppath $(@D)/tmp \
		--rootpath $(@D)/dummyroot \
		--mcopy $(HOST_DIR)/bin/mcopy \
		--mkdosfs $(HOST_DIR)/sbin/mkdosfs
endef

define BOYSENBOARD_FLASHDRIVE_INSTALL_IMAGES_CMDS
	mkdir -p $(BINARIES_DIR)
	cp $(@D)/flashdrive.img $(BINARIES_DIR)/flashdrive.img
endef

$(eval $(generic-package))
