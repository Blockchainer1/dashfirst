Sample init scripts and service configuration for dashfirstd
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/dashfirstd.service:    systemd service unit configuration
    contrib/init/dashfirstd.openrc:     OpenRC compatible SysV style init script
    contrib/init/dashfirstd.openrcconf: OpenRC conf.d file
    contrib/init/dashfirstd.conf:       Upstart service configuration file
    contrib/init/dashfirstd.init:       CentOS compatible SysV style init script

1. Service User
---------------------------------

All three Linux startup configurations assume the existence of a "dashfirstcore" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes dashfirstd will be set up for the current user.

2. Configuration
---------------------------------

At a bare minimum, dashfirstd requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, dashfirstd will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that dashfirstd and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If dashfirstd is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running dashfirstd without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/dashfirst.conf`.

3. Paths
---------------------------------

3a) Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/dashfirstd`  
Configuration file:  `/etc/dashfirstcore/dashfirst.conf`  
Data directory:      `/var/lib/dashfirstd`  
PID file:            `/var/run/dashfirstd/dashfirstd.pid` (OpenRC and Upstart) or `/var/lib/dashfirstd/dashfirstd.pid` (systemd)  
Lock file:           `/var/lock/subsys/dashfirstd` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the dashfirstcore user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
dashfirstcore user and group.  Access to dashfirst-cli and other dashfirstd rpc clients
can then be controlled by group membership.

3b) Mac OS X

Binary:              `/usr/local/bin/dashfirstd`  
Configuration file:  `~/Library/Application Support/DashFirstCore/dashfirst.conf`  
Data directory:      `~/Library/Application Support/DashFirstCore`
Lock file:           `~/Library/Application Support/DashFirstCore/.lock`

4. Installing Service Configuration
-----------------------------------

4a) systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start dashfirstd` and to enable for system startup run
`systemctl enable dashfirstd`

4b) OpenRC

Rename dashfirstd.openrc to dashfirstd and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/dashfirstd start` and configure it to run on startup with
`rc-update add dashfirstd`

4c) Upstart (for Debian/Ubuntu based distributions)

Drop dashfirstd.conf in /etc/init.  Test by running `service dashfirstd start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

4d) CentOS

Copy dashfirstd.init to /etc/init.d/dashfirstd. Test by running `service dashfirstd start`.

Using this script, you can adjust the path and flags to the dashfirstd program by
setting the DFCND and FLAGS environment variables in the file
/etc/sysconfig/dashfirstd. You can also use the DAEMONOPTS environment variable here.

4e) Mac OS X

Copy org.dashfirst.dashfirstd.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.dashfirst.dashfirstd.plist`.

This Launch Agent will cause dashfirstd to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run dashfirstd as the current user.
You will need to modify org.dashfirst.dashfirstd.plist if you intend to use it as a
Launch Daemon with a dedicated dashfirstcore user.

5. Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
