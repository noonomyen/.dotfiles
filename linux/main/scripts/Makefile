USER_BINDIR ?= $(HOME)/.local/bin
SYS_BINDIR ?= /usr/local/bin

.PHONY: help install uninstall check-not-root

help:
	@echo "Installation targets:"
	@echo "  make install   - Install all scripts (prompts for sudo internally if needed)"
	@echo "  make uninstall - Remove all scripts"

check-not-root:
	@if [ "$$(id -u)" = "0" ]; then \
		echo "ERROR: Do not run this Makefile with root/sudo. Run as normal user."; \
		exit 1; \
	fi

install: check-not-root
	@echo "Installing user scripts to $(USER_BINDIR)..."
	install -d $(DESTDIR)$(USER_BINDIR)
	install -m 755 gdro $(DESTDIR)$(USER_BINDIR)/gdro
	@echo "Installing system scripts to $(SYS_BINDIR) (requires sudo)..."
	sudo install -d $(DESTDIR)$(SYS_BINDIR)
	sudo install -m 755 dgpu-mode $(DESTDIR)$(SYS_BINDIR)/dgpu-mode
	sudo install -m 755 huge $(DESTDIR)$(SYS_BINDIR)/huge
	@echo "Done!"

uninstall: check-not-root
	@echo "Removing user scripts from $(USER_BINDIR)..."
	rm -f $(DESTDIR)$(USER_BINDIR)/gdro
	@echo "Removing system scripts from $(SYS_BINDIR) (requires sudo)..."
	sudo rm -f $(DESTDIR)$(SYS_BINDIR)/dgpu-mode
	sudo rm -f $(DESTDIR)$(SYS_BINDIR)/huge
	@echo "Done!"
