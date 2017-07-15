FROM library/ubuntu:latest

ENV container docker
STOPSIGNAL SIGRTMIN+3

RUN apt-get update && apt-get install dbus -y --force-yes

COPY initbuntu.sh /sbin/initbuntu.sh
RUN chmod 0744 /sbin/initbuntu.sh

CMD bash -c "/sbin/initbuntu.sh && /bin/systemd --system --unit=basic.target"