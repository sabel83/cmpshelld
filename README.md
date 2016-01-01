# C++ metaprogramming shell daemon

This repository contains a setup script for the
[Metashell](github.com/sabel83/metashell) online demo on an Ubuntu server.
You can use it to host your own online demo of the shells.

## Setting your server up

* Install Ubuntu server 14.04
* Download the content of this repository
* Run `install.sh`. This will install the dependent packages, create the daemons
  and start them.

* The Metashell demo will be listening on port `4202`
* The Preshell demo will be listening on port `4201`

* The demos use ShellInABox, which gets installed on your server and is
  listening on port 4200 by default. To stop it run
  `sudo /etc/init.d/shellinabox stop`. To avoid it being started during system
  startup run `sudo update-rc.d shellinabox disable`

## The services providing the demo

The demo is provided by two services:

* `metashell` This is a ShellInABox service running Metashell as its shell.
* `shell_demo` This is a service periodically updating the C++ headers which
  can be used from the services and building the latest version of Preshell
  and Metashell.

The services are using the `/usr/local/share/shell_demo` directory for
downloading the source code of different projects (Metashell, Preshell,
libraries that can be used from the shell) and building the Metashell and
Preshell binaries.

## Starting the demos

The installer configures the demos to be automatically started during system
startup. To start them manually run the following commands:

```
sudo /etc/init.d/shell_demo start
sudo /etc/init.d/metashell start
```

## Stopping the demos

To stop the demo, you need to stop the three services providing it:

```
sudo /etc/init.d/shell_demo stop
sudo /etc/init.d/metashell stop
```

