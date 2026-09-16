CONFIG_DIR ?= $(HOME)/.config

.PHONY: install install-udev

install:
	mkdir -p $(CONFIG_DIR)
	cp -a .config/. $(CONFIG_DIR)/

install-udev:
	sudo install -m 644 etc/udev/rules.d/99-gpu-symlinks.rules /etc/udev/rules.d/
	sudo udevadm control --reload-rules
	sudo udevadm trigger -s drm
