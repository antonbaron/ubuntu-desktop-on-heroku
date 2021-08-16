FROM ubuntu:20.10
ENV DEBIAN_FRONTEND=noninteractive

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

RUN apt-get update && apt-get install -y --no-install-recommends \
    dbus-x11 nano sudo bash net-tools \
    novnc x11vnc xvfb \
    zip unzip supervisor curl git wget ssh terminator \
    xfce4 \
    gnome-shell ubuntu-gnome-desktop gnome-session gdm3 tasksel \
    gnome-session gdm3 tasksel \
    gedit \
    google-chrome-stable

RUN apt-get autoclean
RUN apt-get autoremove

COPY nov.zip /nov.zip

COPY . /system
RUN unzip /nov.zip
RUN cp -r /novnc/ /usr/share/
RUN mv /usr/share/novnc/vnc_lite.html /usr/share/novnc/ignO.1
RUN mv /usr/share/novnc/vnc.html /usr/share/novnc/index.html
RUN chmod +x /system/conf.d/websockify.sh
RUN chmod +x /system/run.sh

CMD ["/system/run.sh"]
