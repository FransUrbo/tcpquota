#
#	Makefile för tcpquota paketet.. /marbud
#
# $Header: /usr/lib/cvs/root/tcpquota/Makefile,v 1.86 1998/08/30 07:11:46 turbo Exp $
#
# $Log: Makefile,v $
# Revision 1.86  1998/08/30 07:11:46  turbo
# * Spaces fixed in the 'Installing xxx' to make it look better... :)
# * Tell user to use 'dpkg-buildpackage -rsudo' instead of 'sudo build'...
#
# Revision 1.85  1998/08/29 21:10:53  turbo
# Darn!! The 'upstream' changes file should be 'changelog', not 'changes'...
#
# Revision 1.84  1998/08/29 20:17:16  turbo
# 'create_database.sql' isn't a (library-) binary, it's a library.. Don't make
# it executable... :)
#
# Revision 1.83  1998/08/27 11:50:16  turbo
# Add our new 'changes' file to the 'debian/changelog', so that we have a
# visable history...
#
# Revision 1.82  1998/08/27 03:06:33  turbo
# * Moved the rtag'ing and commit'ing of the .version* files from the debian
#   target, to the rtag target...
#
# Revision 1.81  1998/08/27 03:02:09  turbo
# * Copy the base README.debian from the .readme, so that lintian stops
#   complaining about it being a template file... *puh*
#
# Revision 1.80  1998/08/02 19:17:10  turbo
# Use debhelper (dh_make) to create the debian package, with our own
# rules file...
#
# Revision 1.79  1998/08/02 17:44:58  turbo
# * One liner variable declaration at the top.
# * CFG_INSTALL uses 'install', and installs as user root, group root instead
#   of user man, group man...
# * SYS_INSTALL should be BIN_INSTALL, because it installs files executable..
# * Moved any directory creation to a separate target, create_dirs, which is
#   called from the 'install' target.
# * When doing a install, we do a ordinary install_configs, not a debian version
#   (I'm using debhelper now, which lets me specify exacly which targets should
#   be called when creating the package). Also do not execute the 'restart' target
#   when installing, let the user decide when to start the daemon. We should also
#   install the dummy cron script, instead of the CCW specific one.
# * When doing a update, do not update the config files, nore should we restart.
# * Rewrote the uninstall target, better to find all the files installed, but
#   I probably missed some, but who cares... :)
#
# Revision 1.78  1998/08/01 19:42:44  turbo
# Since porting the programs to use the generic database interface DBI, I
# needed two new variables, 'PORT' and 'ENGINE'. PORT is simply the port at
# which the SQL server is listening on. The ENGINE is what kind of SQL server
# we are running (DBI driver name) ie mSQL or mysql.
#
# Revision 1.77  1998/06/12 14:43:04  turbo
# New free user for CCW.. 'nas98'...
#
# Revision 1.76  1998/05/24 20:58:12  turbo
# Ouups... Install the cron script executable... *blush*
#
# Revision 1.75  1998/05/24 20:39:11  turbo
# No real changes, just retabbed the 'done' part to get a cleaner output when
# updating binaries/scripts...
#
# Revision 1.74  1998/05/24 20:27:23  turbo
# New CCW specific variable in the config file that we have to account for, FREE.
# Users that are not _REAL_ users, but some kind of virtual users, or admin's etc...
#
# Revision 1.73  1998/05/17 11:10:24  turbo
# * Our second net is 192.168, not 198.168... *blush*
# * Support both libc5 AND libc6 with the variable 'UTMP'... (Install both
#   version, but link the korrect to 'utmp.ph').
#
# Revision 1.72  1998/05/14 16:59:08  turbo
# New config variable, LOCALNET. Stack each network number you have here, space
# separated.
#
# Revision 1.71  1998/04/26 14:53:56  turbo
# When we are restarting the daemon, first send a SIGUSR1 (debug ON)
# to it, so it woun't clean the firewall...
#
# Revision 1.70  1998/04/19 10:59:24  turbo
# * Added a install target for the new program, 'chkisdnlog'
# * Use 'install' instead of 'cp'...
#
# Revision 1.69  1998/04/15 19:35:00  turbo
# Removed the CHANGES file.... It's not needed, there for
# removed any reference to that in the Makefile.
#
# Revision 1.68  1998/04/13 11:06:02  turbo
# Since we specified the absolute path in the variable declaration to the
# config files, we don't need to copy 'confs/<file>' but mearly '<file>'...
#
# Revision 1.67  1998/04/13 10:34:47  turbo
# * Install the database creation SQL script in the libdirectory, so the
#   Debian postinst can find it...
# * The config files had been moved, make sure we find them in there correct
#   directory ('confs/...')
# * To make the creation of the Debian package easier to find the manuals in
#   there right place (the temp directory) we link 'DESTDIR/usr...' instead of
#   just '/usr...'. Otherwise they will not be found
# * Nicer and better centered progress output
#
# Revision 1.66  1998/04/01 14:18:26  turbo
# * Don't forget to SED the confs dir (to .../CFGDIR).
# * Make sure the config dir is 'executable' after creation...
#
# Revision 1.65  1998/03/31 12:26:22  turbo
# Added some greet/info files, instead of hard coding them in
# the programs... Make sure we install them to...
#
# Revision 1.64  1998/03/31 11:46:16  turbo
# Moved the config files to a separate directory, make sure we
# copy the right file from the right directory...
#
# Revision 1.63  1998/03/21 22:50:34  turbo
# * Don't forget to install the little 'cron library script' in the lib dir...
# * Make sure we edit the necessary files BEFORE we make the package...
#
# Revision 1.62  1998/03/17 18:57:59  turbo
# * DESTDIR wasn't needed down below... We already configured the BINDIR/SYSDIR
#   to use that variable...
# * Don't use absolute paths in the install target, use the configured variables...
# * the 'openhost' script had to be SUID after all, we don't want to add all
#   users allowed TCPQuota write access to the database!!!
#
# Revision 1.61  1998/03/15 11:14:37  turbo
# Oopps.. The 'tcp_masq_openhost' was in '/usr/bin' not '/usr/sbin', therefor
# the link to 'openhost' was dangling...
#
# Revision 1.60  1998/03/15 10:40:01  turbo
# Moved the 'verifytcpquota' to '/usr/lib/tcpquota' instead, that way I don't
# have to write a manual for it... :) It's no user executable binary any way...
# Make sure we call the target 'library_binaries' to install it in '/usr/lib/tcpquota'.
#
# Revision 1.59  1998/03/15 09:52:40  turbo
# * When makeing the target 'database', which calles the script
#   '.postinst', make sure the script exists...
# * Make sure the post{inst|rm} script is executable...
#
# Revision 1.58  1998/03/14 23:30:37  turbo
# * Remove some more example files...
# * Instead of one big line of output when telling the user
#   that the debian package can be done and how, split it
#   in two..
#
# Revision 1.57  1998/03/14 23:00:52  turbo
# * Make sure that all links are absolute... (lintian demans that)
# * Don't install the openfw SUID, no need for that now, since
#   the daemon takes care of opening/closing the firewall...
#
# Revision 1.56  1998/03/13 15:06:42  turbo
# Duhhh.... Just a space in an echo... Boring!
#
# Revision 1.55  1998/02/15 18:24:23  turbo
# When making the Debian package, don't forget to edit the copyright file...
#
# Revision 1.54  1998/02/12 15:29:06  turbo
# * Removed the symlink 'ut', it is very 'swedish' like, this should be
#   universal package (besides, Debian thinks this is 'namespace polution')
# * Added dummy manual pages for the installation scripts/configs.
#
# Revision 1.53  1998/01/26 21:48:09  turbo
# Make sure we create the manual links to the
# program links ut, openfw and openhost.
#
# Revision 1.52  1998/01/23 17:22:38  turbo
# Fixed some spelling errors...
#
# Revision 1.51  1998/01/23 16:03:40  turbo
# Don't forget to call the target 'install_manuals' when installing or updating.
#
# Revision 1.50  1998/01/23 16:01:36  turbo
# Added the 'install_manuals' target. Installs every manual in '$(xxx_MANUALS)'
# in it's propper place...
#
# Revision 1.49  1998/01/23 12:54:14  turbo
# Added a target to update the CHANGES file when making a debian package...
# Just run 'cvs log tcpquotad > CHANGES' and we have a full log of what's
# happened to tcpquotad...
#
# Revision 1.48  1998/01/23 11:03:39  turbo
# Before we build the Debian package, make sure we edit the changes file...
#
# Revision 1.47  1998/01/18 01:28:14  turbo
# When we are making a debian package, first do the 'rtag' target (which updates
# the version files, and checks them in) THEN we clean the directory...
#
# Revision 1.46  1998/01/16 14:09:20  turbo
# * Added the config script, 'tcp_quotaconfig' to the list of files to install.
# * If we are installing, we should call the 'install_configs_debian' target,
#   and when updating, we should call the 'install_configs' target.
# * Retabbing the lines a little, make the file look a little cleaner...
#
# Revision 1.45  1997/12/03 14:36:06  turbo
# Crapp commit, ignore...
#
# Revision 1.44  1997/12/02 21:52:13  turbo
# Do 'rtag' when making a debian package...
#
# Revision 1.43  1997/12/02 20:38:12  turbo
# When installing the config file, use sed to replace some variables in it...
# This way we can, when installing via debian package, ask how the programs
# should behave (using sed there to)...
#
# Revision 1.42  1997/12/02 20:12:16  turbo
# * When we are making a debian package, we should exchange the hardcoded location
#   to the correct location...
# * Cleanup of the installation output...
#
# Revision 1.41  1997/12/02 19:31:52  turbo
# When making a debian package, no need to pack it into a tar archive, it is
# done anyway. The only reason this was called/made, was to clean the directory
# from the CVS dirs...
#
# Revision 1.40  1997/12/01 14:19:55  turbo
# * The library files should be in 'PREFIX/lib/tcpquota', not 'PREFIX/etc'...
# * Don't forget to install the utmp header file...
# * Do not try to install the debug config file, it have been removed...
# * Only try to create the libdir if it does not exists already...
#
# Revision 1.39  1997/11/18 13:52:54  turbo
# The library file(s) should go in 'PREFIX/lib/tcpquota'...
#
# Revision 1.38  1997/11/11 14:41:27  turbo
# Added the system binary 'tcp_masq_openfw', installes to PREFIX/sbin
#
# Revision 1.37  1997/11/04 14:52:00  turbo
# Instead of changing 'lib' to configdir, change './lib' to configdir...
#
# Revision 1.36  1997/10/19 21:01:47  turbo
# Bugg in the substitution of the CFGDIR when _NOT_ making a debian package...
#
# Revision 1.35  1997/10/19 19:34:25  turbo
# When changing the search paths inside the script, use a separate variable,
# CFGDIRSED instead of the install variable CFGDIR... If one tries to make
# a Debian package those two differs, otherwise not...
#
# Revision 1.34  1997/10/19 18:49:49  turbo
# The script 'tcpquota' have been removed... Use 'chktcpquota' instead...
#
# Revision 1.33  1997/10/19 13:40:35  turbo
# Fixed so that the debianization works...
# New major version...
#
# Revision 1.32  1997/10/16 20:41:42  turbo
# Added the option to restart the tcpquota daemon if we are updating the binaries...
#
# Revision 1.31  1997/10/06 17:56:41  turbo
# * We should realy have different CFGDIR if we installing 'plain' or 'debian'
# * Check if there is any old binaries before moving them (one cant move a non-
#   existent file, you know... :) Same with the cron script dir etc...
#
# Revision 1.30  1997/10/05 17:24:02  turbo
# Before linking 'tcpquotatop' to 'toptcp', remove 'toptcp'...
#
# Revision 1.29  1997/10/03 15:46:34  turbo
# Make a link from 'tcpquotatop' to 'toptcp'...
#
# Revision 1.28  1997/09/30 17:10:58  turbo
# * You can not have a 'multiline' OR... ('open() || <multiline>').
# * Make sure the tcp_masq_openhost is suid root...
#
# Revision 1.27  1997/09/26 17:44:03  turbo
# * Got the rtag/rdiff target to work...
#
# Revision 1.26  1997/09/26 17:16:56  turbo
# * Added the rdiff target...
# * Change the depends for the debian target, now depends on rdiff instead of
#   newversion...
# * Removed the newversion target... Use rdiff instead...
#
# Revision 1.25  1997/09/26 16:25:52  turbo
# * Tell the user WHERE we install the program, ordinary installation in
#   '/usr/local' and when making a Debian package, in '/usr' unless PREFIX is
#   defined on the command line...
#
# Revision 1.24  1997/09/26 16:20:44  turbo
# Make sure we install in '/usr/local' as default...
#
# Revision 1.23  1997/09/26 15:50:40  turbo
# CFGDIR should be in '$(DESTDIR)/$(PREFIX)/etc', not '$(DESTDIR)/etc/tcpquota'.
#
# Revision 1.22  1997/09/24 20:36:25  marbud
# Resolved some conflicts.
#
# Revision 1.21  1997/08/17 17:16:56  turbo
# * Fixed some buggs and spelling errors.
# * When installing, echo a dot for each file installed, cleaned...
# * Added support for a library file, where some functions that are used by
#   more than one script is located...
#
# Revision 1.20  1997/08/14 17:57:30  turbo
# Found a little bugg, concerned the moving of the old tcpquotad...
#
# Revision 1.19  1997/08/14 17:28:14  turbo
# Added a lot more make destination, all to be able to make a Debian package
# and propper installation.
#
# BEWARE!!! 'make install' now makes a compleat installation, creating the
# database if it does not exists...
#
# Revision 1.18  1997/05/29 21:41:37  marbud
# Lagt till tcpperiod programmet..
#
# Revision 1.17  1997/04/13 00:41:38  marbud
# Lagt till installering av tcpquotatop.. Bytt till TAB istf 8*SPC på en
# del ställen...
#
# Revision 1.16  1997/04/12 18:55:49  marbud
# Lagt till tcpquotatop i Makefile
#
# tcpquota top är en ny produkt som visar vilka som debiteras och hur mycket.
#
#
#

# Default behaviour for the programs... CCW specific, CHANGE!!!
PROTOCOL = isdn
LOC_ADDR = 195.100.170.187
REM_ADDR = 195.100.20.3
LOCALNET = 42.42.0.0 192.168.0.0
GROUP1   = machiavelli kaddaffi karadicz semin khomeini muboto chauchesko baptista
GROUP2   = idiamin saddam mao lenin adolf kim pinochet castro
GROUP3   = cleon indbur loris wienis asper stettin gilmer stannell
FREE     = free admin rc564 monitorn nas98
SERVER   = localhost
PORT     = 3306
ENGINE   = mySQL
UTMP     = libc6

# ============================
# No servicable parts below...

# Files...
PACKAGE       = tcpquota
SYST_BINARIES = addtcpquota chktcpquota tcpquotaadmin tcpquotad tcpperiod tcp_masq_openfw
LIBR_BINARIES = tcpquotaconfig verifytcpquotad
USER_BINARIES = tcp_masq_openhost tcpquotatop topnet topmasq
CONFIG_FILES  = confs/tcpquota.cf confs/tcpquota.greet.svenska confs/tcpquota.greet.english \
		confs/tcpquota.info.english confs/tcpquota.info.svenska
START_SCRIPT  = confs/tcpquota.init
CRON_SCRIPT   = confs/tcpquota.cron
LIBRARY_FILE  = lib/tcpquota.pl lib/utmp_libc5.ph lib/utmp_libc6.ph lib/cron_functions.pl create_database.sql

SYST_MANUALS  = addtcpquota.8 tcp_masq_openfw.8 tcpquotaadmin.8 \
		chktcpquota.8 tcpperiod.8 tcpquotad.8
USER_MANUALS  = tcp_masq_openhost.1 tcpquotatop.1 topmasq.1 topnet.1
CONFIG_MANUALS= tcpquota.cf.5

# This bugger is only here to be able to make
# a debian package, please ignore, should be empty...
DESTDIR       =

# Where is perl?
PERL          = `which perl`

ifdef DESTDIR
# Debian installation...

# Where to install
PREFIX = /usr

# Call with 'make PREFIX=/usr/local' to install in '/usr/local'...
BINDIR = $(DESTDIR)/$(PREFIX)/bin
SYSDIR = $(DESTDIR)/$(PREFIX)/sbin
MANDIR = $(DESTDIR)/$(PREFIX)/man
LIBDIR = $(DESTDIR)/$(PREFIX)/lib/tcpquota
CFGDIR = $(DESTDIR)/etc/tcpquota

LIBDIRSED = $(PREFIX)/lib/tcpquota
CFGDIRSED = /etc/tcpquota
else
# Ordinary installation...

# Where to install
PREFIX = /usr/local

BINDIR = $(PREFIX)/bin
SYSDIR = $(PREFIX)/sbin
MANDIR = $(PREFIX)/man
LIBDIR = $(PREFIX)/lib/tcpquota
CFGDIR = $(PREFIX)/etc/tcpquota

LIBDIRSED = $(PREFIX)/lib/tcpquota
CFGDIRSED = $(PREFIX)/etc/tcpquota
endif

export LIBDIR CFGDIR ENGINE

CFG_INSTALL = install -g root -m 644
BIN_INSTALL = install -g root -o root -m 750

all:
	@( \
	echo "Use: 'make update'    to update binaries,"; \
	echo "     'make install'   to make a new installation, and"; \
	echo "     'make uninstall' to remove the whole TCPQuota package..."; \
	)

clean:
	@( \
	echo -n "Cleaning source directory"; \
	for file in `find -name '*~'`; do \
		echo -n "."; \
		rm -f $$file; \
	done; \
	for file in `find -name '.*~'`; do \
		echo -n "."; \
		rm -f $$file; \
	done; \
	for file in `find -name '#*#'`; do \
		echo -n "."; \
		rm -f $$file; \
	done; \
	echo ""; \
	)

diff:
	@cvs diff | less

rdiff:
	# Make a unified diff over the changes from the last version...
	@( \
	VERSION=`cat .version.old`; \
	MAJOR=`expr substr $$VERSION 1 1`; \
	MINOR=`expr substr $$VERSION 3 1`; \
	LEVEL=`expr substr $$VERSION 5 2`; \
	TAG="`echo $(PACKAGE)`_`echo $$MAJOR`_`echo $$MINOR`_`echo $$LEVEL`"; \
	echo cvs rdiff: $$TAG; \
	cvs rdiff -ur $$TAG $(PACKAGE); \
	)

update:  clean install_bins_user install_bins_system \
	 start_script cron_script library_file library_binaries install_manuals

install: clean create_dirs install_bins_user install_bins_system \
	 install_configs start_script cron_script library_file \
	 library_binaries install_manuals database

create_dirs:
	@( \
	  if [ ! -d $(CFGDIR) ]; then \
	    echo -n "  Creating config dir... "; \
	    mkdir -p $(CFGDIR); \
	    chmod -R a+x $(CFGDIR); \
	    echo "           done."; \
	  fi; \
	  if [ ! -d $(CFGDIR) ]; then \
	    echo -n "Creating config dir... "; \
	    mkdir -p $(CFGDIR); \
	    echo "          done. (DEBIAN)"; \
	  fi; \
	  if [ ! -d $(LIBDIR) ]; then \
	    echo -n "  Creating lib dir... "; \
	    mkdir -p $(LIBDIR); \
	    echo "              done."; \
	  fi; \
	  mkdir -p $(MANDIR)/man1; \
	  mkdir -p $(MANDIR)/man5; \
	  mkdir -p $(MANDIR)/man8; \
	  mkdir -p $(DESTDIR)/etc/init.d; \
	)

install_bins_user:
	@( \
	echo "Installing in $(PREFIX)..."; \
	echo '-------------'; \
	echo -n "Installing user binaries"; \
	for file in $(USER_BINARIES); do \
		echo -n "."; \
		sed -e "s@/usr/local/bin@$(PREFIX)/bin@g" \
		    -e "s@/usr/local/sbin@$(PREFIX)/sbin@g" \
		    -e "s@/usr/local/etc@$(CFGDIRSED)@g" \
		    -e "s@/usr/bin/perl@$(PERL)@g" \
		    -e "s@./lib@$(LIBDIRSED)@g" \
		    -e "s@./confs@$(CFGDIRSED)@g" \
		    < $$file > $(BINDIR)/$$file; \
		chown root.root $(BINDIR)/$$file; \
		chmod 755 $(BINDIR)/$$file; \
	done; \
	cd $(BINDIR); \
	rm -f toptcp; \
	chmod u+s $(BINDIR)/tcp_masq_openhost; \
	ln -sf $(BINDIR)/tcpquotatop $(BINDIR)/toptcp; \
	ln -sf $(BINDIR)/tcp_masq_openhost $(BINDIR)/openhost; \
	echo "        done."; \
	)

install_bins_system:
	@( \
	echo -n "Installing system binaries"; \
	if [ -e $(SYSDIR)/tcpquotad ]; then \
	  mv $(SYSDIR)/tcpquotad $(SYSDIR)/tcpquotad.old; \
	fi; \
	for file in $(SYST_BINARIES); do \
		echo -n "."; \
		sed -e "s@/usr/local/bin@$(PREFIX)/bin@g" \
		    -e "s@/usr/local/sbin@$(PREFIX)/sbin@g" \
		    -e "s@/usr/local/etc@$(CFGDIRSED)@g" \
		    -e "s@/usr/bin/perl@$(PERL)@g" \
		    -e "s@./lib@$(LIBDIRSED)@g" \
		    -e "s@./confs@$(CFGDIRSED)@g" \
		    < $$file > $(SYSDIR)/$$file; \
		chown root.root $(SYSDIR)/$$file; \
		chmod 755 $(SYSDIR)/$$file; \
	done; \
	cd $(SYSDIR); \
	rm -f openfw; \
	ln -sf $(SYSDIR)/tcp_masq_openfw $(SYSDIR)/openfw; \
	echo "    done."; \
	)

install_chkisdn:
	$(BIN_INSTALL) chkisdnlog $(SYSDIR)

install_configs:
	@( \
	  echo -n "Installing configuration files"; \
	  for file in $(CONFIG_FILES); do \
	    name=`basename $$file`; \
	    echo -n "."; \
	    $(CFG_INSTALL) $$file $(CFGDIR)/$$name; \
	  done; \
	  echo " done."; \
	)

update_configs:
	@( \
	  echo -n "Updating configuration files  "; \
	  for file in $(CONFIG_FILES); do \
	    name=`basename $$file`; \
	    echo -n "."; \
	    sed -e "s@%PROTOCOL%@$(PROTOCOL)@g" \
		-e "s@%LOC_ADDR%@$(LOC_ADDR)@g" \
		-e "s@%REM_ADDR%@$(REM_ADDR)@g" \
		-e "s@%LOCALNET%@$(LOCALNET)@g" \
		-e "s@%FREE%@$(FREE)@g" \
		-e "s@%GROUP1%@$(GROUP1)@g" \
		-e "s@%GROUP2%@$(GROUP2)@g" \
		-e "s@%GROUP3%@$(GROUP3)@g" \
		-e "s@%SERVER%@$(SERVER)@g" \
		-e "s@%PORT@$(PORT)@g" \
		-e "s@%ENGINE%@$(ENGINE)@g" \
	    < $$file > $(CFGDIR)/$$name; \
	    chown root.root $(CFGDIR)/$$name; \
	    chmod 644 $(CFGDIR)/$$name; \
	  done; \
	  echo " done."; \
	)

install_configs_debian:
	@( \
	  echo -n "Installing configuration files"; \
	  for file in $(CONFIG_FILES); do \
	    echo -n "."; \
	    $(CFG_INSTALL) $$file $(CFGDIR); \
	  done; \
	  echo " done. (DEBIAN)"; \
	)

install_manuals:
	@( \
	  echo -n "Installing manuals"; \
	  for file in $(USER_MANUALS); do \
	    echo -n "."; \
	    $(CFG_INSTALL) man/$$file $(MANDIR)/man1; \
	  done; \
	  for file in $(CONFIG_MANUALS); do \
	    echo -n "."; \
	    $(CFG_INSTALL) man/$$file $(MANDIR)/man5; \
	  done; \
	  for file in $(SYST_MANUALS); do \
	    echo -n "."; \
	    $(CFG_INSTALL) man/$$file $(MANDIR)/man8; \
	  done; \
	  ln -sf $(DESTDIR)/usr/man/man1/tcp_masq_openhost.1.gz $(DESTDIR)/usr/man/man1/openhost.1.gz; \
	  ln -sf ../man7/undocumented.7.gz $(DESTDIR)/usr/man/man1/toptcp.1.gz; \
	  ln -sf $(DESTDIR)/usr/man/man8/tcp_masq_openfw.8.gz $(DESTDIR)/usr/man/man8/openfw.8.gz; \
	  echo "       done."; \
	)

start_script:
	@( \
	  echo -n "Installing start script"; \
	  echo -n "."; \
	  echo -n "."; \
	  sed -e "s@/usr/local/sbin@$(PREFIX)/sbin@g" \
	    < $(START_SCRIPT) > $(DESTDIR)/etc/init.d/tcpquotad; \
	  echo -n "."; \
	  chmod 755 $(DESTDIR)/etc/init.d/tcpquotad; \
	  echo "          done."; \
	)

cron_script:
	@( \
	  echo -n "Installing cron script"; \
	  echo -n "."; \
	  $(BIN_INSTALL) $(CRON_SCRIPT) $(DESTDIR)/etc/cron.weekly/tcpquotad; \
	  echo "             done."; \
	)

library_file:
	@( \
	  echo -n "Installing support libraries"; \
	  for file in $(LIBRARY_FILE); do \
	    echo -n "."; \
	    $(CFG_INSTALL) $$file $(LIBDIR); \
	  done; \
	  $(CFG_INSTALL) .dummy_cron_lib $(LIBDIR)/cron_functions.pl; \
	  cd $(LIBDIR); \
	  rm -f utmp.ph; \
	  ln -s utmp_$(UTMP).ph utmp.ph; \
	  echo "   done."; \
	)

library_binaries:
	@( \
	  echo -n "Installing library binaries"; \
	  for file in $(LIBR_BINARIES); do \
	    echo -n "."; \
	    $(BIN_INSTALL) $$file $(LIBDIR); \
	  done; \
	  echo "       done."; \
	)

database:
	@( \
	  if [ -x ./.postinst ]; then \
	    ./.postinst; \
	  fi; \
	)

restart:
	@( \
	  PID=`cat /var/run/tcpquotad.pid`; \
	  kill -USR1 $$PID; \
	  $(DESTDIR)/etc/init.d/tcpquotad stop; \
	  $(DESTDIR)/etc/init.d/tcpquotad start; \
	)

uninstall:
	@( \
	  echo "Removing the following files:"; \
	  if [ -d $(CFGDIR) ]; then \
		rm -vR $(CFGDIR); \
	  fi; \
	  if [ -d $(LIBDIR) ]; then \
		rm -vR $(LIBDIR); \
	  fi; \
	  for file in $(USER_BINARIES); do \
		rm -vf $(BINDIR)/$$file; \
	  done; \
	  for file in $(SYST_BINARIES); do \
		rm -vf $(SYSDIR)/$$file; \
	  done; \
	  for file in $(USER_MANUALS); do \
	  	rm -vf $(MANDIR)/man1/$$file; \
	  done; \
	  for file in $(CONFIG_MANUALS); do \
	  	rm -vf $(MANDIR)/man5/$$file; \
	  done; \
	  for file in $(SYST_MANUALS); do \
	  	rm -vf $(MANDIR)/man8/$$file; \
	  done; \
	)

#	  if [ -x ./.postrm ]; then \
#	    ./.postrm; \
#	  fi; \

debian: rtag clean
	@( \
	  echo "Removing crappy files... "; \
	  echo "  (Errors like \`No such file or directory' is expected)"; \
	  find -type d -name CVS -exec rm -Rf {} \;; \
	  find -type f -name '*.org' -exec rm -R {} \;; \
	  cd ..; \
	  VERSION=`cat $(PACKAGE)/.version`; \
	  mv $(PACKAGE) $(PACKAGE)-$$VERSION; \
	  cd $(PACKAGE)-$$VERSION; \
	  dh_make; \
	  cd debian; \
	  echo "Changing and removing some files in the debian directory..."; \
	  rm -f *.ex; \
	  cat ../changelog  >> changelog; \
	  cat ../.readme     > README.debian; \
	  cat ../.control    > control; \
	  cat ../.copyright >> copyright; \
	  cat ../.dirs       > dirs; \
	  cat ../.postinst   > postinst; \
	  cat ../.postrm     > postrm; \
	  cat ../.purge      > purge; \
	  cat ../.conffiles  > conffiles; \
	  cat ../.crontab    > crontab; \
	  cat ../.doc-files  > tcpquota-doc.files; \
	  cat ../.rules      > rules; \
	  chmod +x postinst postrm purge; \
	  $$EDITOR copyright changelog; \
	  cd ..; \
	  echo; \
	  cat .dummy_cron_lib > lib/cron_functions.pl; \
	  echo; \
	  echo "Now type \`cd ../$(PACKAGE)-$$VERSION; dpkg-buildpackage -rsudo'"; \
	  echo " and the package will be made..."; \
	)

char:
	@( \
	  mkdir /tmp/$(PACKAGE); \
	  echo -n "Copying files... "; \
	  find | cpio -p /tmp/$(PACKAGE); \
	  cd /tmp/$(PACKAGE); \
	  echo "Removing crappy files... "; \
	  echo "  (Errors like \`No such file or directory' is expected)"; \
	  find -type d -name CVS -exec rm -Rf {} \;; \
	  find -type f -name '*.org' -exec rm -R {} \;; \
	  cd ..; \
	  echo -n "Creating archive... "; \
	  tar czf $(PACKAGE)_`date +%y%m%d`.tgz $(PACKAGE); \
	  echo "done."; \
	)

rtag:
	@( \
	  cp .version .version.old; \
	  VERSION=`cat .version`; \
	  MAJOR=`expr substr $$VERSION 1 1`; \
	  MINOR=`expr substr $$VERSION 3 1`; \
	  LEVEL=`expr substr $$VERSION 5 2`; \
	  NEWLV=`expr $$LEVEL + 1`; \
	  echo "$$MAJOR.$$MINOR.$$NEWLV" > .version; \
	  echo -n "We are now at version "; \
	  cat  < .version; \
	  TAG="`echo $(PACKAGE)`_`echo $$MAJOR`_`echo $$MINOR`_`echo $$LEVEL`"; \
	  echo cvs rtag: $$TAG; \
	  cvs rtag -RF $$TAG $(PACKAGE); \
	  cvs commit .version .version.old; \
	)
