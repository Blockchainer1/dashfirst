
Debian
====================
This directory contains files used to package dashfirstd/dashfirst-qt
for Debian-based Linux systems. If you compile dashfirstd/dashfirst-qt yourself, there are some useful files here.

## dashfirst: URI support ##


dashfirst-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install dashfirst-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your dashfirst-qt binary to `/usr/bin`
and the `../../share/pixmaps/dashfirst128.png` to `/usr/share/pixmaps`

dashfirst-qt.protocol (KDE)

