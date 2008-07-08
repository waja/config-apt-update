# Makefile

all: test install

test:
	# Checking for syntax errors
	set -e; for SCRIPT in scripts/*; \
	do \
		sh -n $$SCRIPT; \
	done

	# Checking for bashisms (currently not failing, but only listing)
	if [ -x /usr/bin/checkbashisms ]; \
	then \
		checkbashisms scripts/* || true; \
	else \
		echo "WARNING: skipping bashism test - you need to install devscripts."; \
	fi

install:
	# Installing scripts
	mkdir -p $(DESTDIR)/usr/share
	cp -r scripts $(DESTDIR)/usr/share/config-apt-update
	chmod -R +x $(DESTDIR)/usr/share/config-apt-update

uninstall:
	# Uninstalling scripts
	rm -rf $(DESTDIR)/usr/share/config-apt-update

reinstall: uninstall install
