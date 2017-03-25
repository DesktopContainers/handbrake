# HandBrake
_HandBrake_

This is a container for the dvd ripping/movie encoding application.

It needs access to /dev/sr0 device and run as privileged container at the moment.

It's based on __DesktopContainers/base-mate__

## Usage: Run the Client

### Simple SSH X11 Forwarding

Since it is an X11 GUI software, usage is in two steps:
  1. Run a background container as server or start existing one.

    docker start handbrake || docker run -d --name handbrake --privileged --device /dev/sr0 -p 8887:80 -v /tmp/:/rips desktopcontainers/handbrake

  2. Connect to the server using `ssh -X`.
     _Logging in with `ssh` automatically opens handbrake_

    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
    -X app@$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' handbrake)

  3. Encode your movies and enjoy.
