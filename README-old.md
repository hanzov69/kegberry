# Kegbone: Complete Beer Tap Monitoring for BeagleBone

Kegbone turns your BeagleBone into an complete beer tap monitoring
system.

Kegbone is based on and includes several opensource projects:

* [Kegbot Server](https://github.com/Kegbot/kegbot-server): Web user interface,
  database backend, API.
* [Kegbot Pycore](https://github.com/Kegbot/kegbot-pycore): Flow monitoring
  and sensing loop.
* [Kegboard](https://github.com/Kegbot/kegboard): Arduino-based firmware and
  schematics for flow sensing, temperature sensing (DS18B20), and
  RFID or OneWire-based authentication tokens.
* [Kegberry](https://github.com/Kegbot/kegberry): Kegberry turns your Raspberry Pi into an complete beer tap monitoring system. Original source of Kegbone

For more information about Kegbot, see the
[Kegbot home page](https://kegbot.org).

**Main Repository:** https://github.com/hanzov69/kegbone


## Instructions

### Prerequisites

Clean install of latest debian image available [here](http://beagleboard.org/latest-images)

* **Kegbot Hardware**: You'll need the Kegbot hardware -- a flow meter and a
  controller board -- in order to collect and report data.
  See [Get Kegbot](https://kegbot.org/get-kegbot) for an overview of the hardware.
* **Dedicated BeagleBoard Black**: The installer script assumes you'll be dedicating
  the target BBB to Kegbone; for example, it replaces the default nginx
  configuration with Kegbot's.
* **Debian**: These instructions assume you've installed a fresh copy of
  [Debian](http://beagleboard.org/latest-images) Tested against 2013-09-04
  ([installation instructions](http://learn.adafruit.com/beaglebone-black-installing-operating-systems/flashing-the-beaglebone-black)).
* **kegbot user**: Configuration files assume we'll be running Kegbot as
  the `kegbot` user. You will need to create this account and it to /etc/sudoers before proceeding.

If your setup doesn't quite match these requirements, don't worry; at
the moment, Kegbone is just a shortcut.  Consult the
[full installation guide](https://kegbot.org/docs/server/) instead.


### Install Kegbone

Connect to your BBB and run the following script:

```
$ bash -c "$(curl -fsSL https://raw.github.com/hanzov69/kegbone/master/src/install.sh)"
```

Sit back and relax as [kegbot-server](https://github.com/Kegbot/kegbot-server),
MySQL, and all related dependencies are installed and configured for you.


### Configure Kegbot Server

Once Kegbone has finished installing your system, you're ready to sign in
and configure your shiny new Kegbot Server.

Navigate to your BBB's IP address in your browser and you should see the
setup wizard.

Once you complete setup, reboot.


## Troubleshooting

To report a problem, please use the
[Kegbone issue tracker](https://github.com/hanzov69/kegbone/issues).


## Upgrading

### Upgrading Kegbot Server

Upgrading `kegbot-server` on a Kegbone device follows the same steps as on
any other Linux server.  See the
[official upgrade docs](https://kegbot.org/docs/server/upgrade-kegbot/) for more
details.

### Upgrading the entire Kegbone image

Kegbone does not (yet) include a full-system updater.  To upgrade a device, we
advise you to backup all data, install a new system image, and re-run the
kegbone installer from scratch.


## Caveats

tbd


## License and Copyright

All code is offered under the GPLv2 license, unless otherwise noted. Please see
LICENSE.txt for the full license.

All code and documentation are Copyright 2014 Bevbot LLC, unless
otherwise noted.

"Kegberry", "Kegbot", and the Kegbot logo are trademarks of Bevbot LLC;
please don't reuse them without our permission.

This is an unofficial fork. Please don't bug the kegbot folks for support with kegbone.

