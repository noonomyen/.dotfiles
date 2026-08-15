USER_BINDIR ?= $(HOME)/.local/bin
SYS_BINDIR ?= /usr/local/bin

.PHONY: help install uninstall

help:
	@echo "Installation targets:"
	@echo "  make install   - Install user and system scripts (use sudo make install for /usr/local/bin)"
	@echo "  make uninstall - Remove installed scripts"

install:
	@echo "Installing user scripts to $(USER_BINDIR)..."
	install -d $(DESTDIR)$(USER_BINDIR)
	install -m 755 gdro $(DESTDIR)$(USER_BINDIR)/gdro
	install -m 755 flameshot-run $(DESTDIR)$(USER_BINDIR)/flameshot-run
	@echo "Installing system scripts to $(SYS_BINDIR)..."
	install -d $(DESTDIR)$(SYS_BINDIR)
	install -m 755 dgpu-mode $(DESTDIR)$(SYS_BINDIR)/dgpu-mode
	install -m 755 memctl $(DESTDIR)$(SYS_BINDIR)/memctl
	install -m 755 clipboard-manager $(DESTDIR)$(SYS_BINDIR)/clipboard-manager
	@echo "Done!"

uninstall:
	@echo "Removing user scripts from $(USER_BINDIR)..."
	rm -f $(DESTDIR)$(USER_BINDIR)/gdro
	rm -f $(DESTDIR)$(USER_BINDIR)/flameshot-run
	@echo "Removing system scripts from $(SYS_BINDIR)..."
	rm -f $(DESTDIR)$(SYS_BINDIR)/dgpu-mode
	rm -f $(DESTDIR)$(SYS_BINDIR)/memctl
	rm -f $(DESTDIR)$(SYS_BINDIR)/clipboard-manager
	@echo "Done!"
