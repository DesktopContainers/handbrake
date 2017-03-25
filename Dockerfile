FROM desktopcontainers/base-mate

MAINTAINER MarvAmBass (https://github.com/DesktopContainers)

ENV libdvdcss2_version 1.2.13-0_amd64

RUN apt-get -q -y update && \
    apt-get -q -y install wget \
                          handbrake \
                          vlc && \
    apt-get -q -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget "http://download.videolan.org/debian/stable/libdvdcss2_$libdvdcss2_version.deb"; \
    dpkg -i libdvdcss2_*.deb; \
    echo "#!/bin/bash\nhandbrake \$*\n" > /bin/ssh-app.sh; \
    mkdir -p /rips

COPY presets "/home/app/Desktop/Handbrake Presets"

RUN chown app.app -R /home/app/Desktop/ /rips && \
    usermod -aG cdrom app

VOLUME ["/rips"]
