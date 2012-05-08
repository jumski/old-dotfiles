# Makefile - makefile for xhotkeys
PACKAGE=xhotkeys

# Destination directoy
DESTDIR= 

# Define destination directories

BINDIR=$(DESTDIR)/usr/bin
SBINDIR=$(DESTDIR)/usr/sbin
MAN1DIR=$(DESTDIR)/usr/share/man/man1
SHAREDIR=$(DESTDIR)/usr/share/$(PACKAGE)
ICONSDIR=$(DESTDIR)/usr/share/icons/hicolor
PIXMAPSDIR=$(DESTDIR)/usr/share/pixmaps
LIBDIR=$(DESTDIR)/usr/lib/$(PACKAGE)
APPDIR=$(DESTDIR)/usr/share/applications
ETCDIR=$(DESTDIR)/etc

# Useful variables
DEBIANDIR=debian
DEBIANVERSION=$(shell cat $(DEBIANDIR)/changelog | head -n1 | awk '{print $$2}' | tr -d '()')
VERSION=$(shell echo $(DEBIANVERSION) | sed "s/-.*$$//")
TARBALL=$(PACKAGE)-$(VERSION).tar.gz
ARCH=$(shell cat $(DEBIANDIR)/control | grep ^Architecture | head -n1 | awk '{print $$2}')
DEBHEADER=$(PACKAGE)_$(DEBIANVERSION)
DEBPACKAGE=$(DEBHEADER)_$(ARCH).deb

FTPSERVER=ftp://savannah.gnu.org/incoming/savannah/$(PACKAGE)/

# ------------- don't edit anything below this line --------------

FILES=xhotkeys.py xhotkeys.glade README TODO Makefile xhotkeys.conf \
	$(DEBIANDIR)/changelog xhotkeys.desktop xhotkeys.png 

ICONS=16x16 32x32 48x48 64x64 96x96 128x128
XPMICON=32x32

all: icons 

web: 
	$(MAKE) -C webpage/$(PACKAGE) || true
	
icons:
	# XPM Icon for pixmaps directory
	mkdir -p icons
	convert xhotkeys.png -resize \!$(XPMICON) icons/xhotkeys.xpm
	
	# PNG Hicolor Icons
	for ICON in $(ICONS); do \
		mkdir -p icons/$$ICON ;\
		convert xhotkeys.png -resize \!$$ICON icons/$$ICON/xhotkeys.png ;\
	done

install: all
	# Create directories
	mkdir -p $(SHAREDIR)
	
	# Install files
	install -m 755 xhotkeys.py $(BINDIR)/xhotkeys
	install -m 644 xhotkeys.glade $(SHAREDIR)
	install -m 644 xhotkeys.1 $(MAN1DIR)
	install -m 644 xhotkeys.desktop $(APPDIR) || true
	install -m 755 getdclick $(SHAREDIR)

	# Install example configuration file
	install -m 644 xhotkeys.conf $(SHAREDIR)/xhotkeys.conf.example
	
	# Install icons
	for ICON in $(ICONS); do \
		mkdir -p $(ICONSDIR)/$$ICON/apps ;\
		install -m 644 icons/$$ICON/xhotkeys.png $(ICONSDIR)/$$ICON/apps ;\
	done
	install -m 644 icons/xhotkeys.xpm $(PIXMAPSDIR) ;\

dist: distclean ../$(TARBALL)

dist-deb:  ../$(DEBPACKAGE)

ChangeLog: debian/changelog
	cat $(DEBIANDIR)/changelog | sed "s/^\(xhotkeys (.*)\).*$$/\1/" | sed "s/[[:space:]]*//" > ChangeLog

../$(TARBALL): clean $(FILES) ChangeLog
	(cd ..; tar --exclude=CVS --exclude=misc --exclude=webpage -czf $(TARBALL) $(PACKAGE))

../$(DEBPACKAGE): ../$(TARBALL)
	CURRENT=$$PWD && \
	TEMP=`mktemp -d` && \
	cp ../$(TARBALL) $$TEMP && \
	tar -C $$TEMP -xvzf ../$(TARBALL) && \
	(cd $$TEMP/$(PACKAGE); fakeroot dpkg-buildpackage) && \
	cp $$TEMP/$(DEBHEADER)* $$CURRENT/.. && \
	rm -rf $$TEMP
	
upload: dist-upload web-upload

dist-upload: dist dist-deb
	rm -f ../$(DEBHEADER)*.sig
	for FILE in `ls ../$(DEBHEADER)*`; do \
		gpg -b --use-agent $$FILE || true; \
	done
	(cd ..; wput $(DEBHEADER)* $(FTPSERVER))

web-upload:
	$(MAKE) -C webpage/$(PACKAGE) upload

clean:
	rm -rf *.pyc icons *.gladep

distclean: clean
	fakeroot $(DEBIANDIR)/rules clean
	rm -f ChangeLog
