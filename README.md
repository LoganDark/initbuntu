initbuntu
=========

A library/ubuntu based image that runs systemd instead of bash

---

This command works best for starting the image:

    docker run --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro -it --rm logandark/initbuntu

---

Notice
------

Docker does not virtualize the kernel. This means that if your kernel does not support systemd, it will not start. This is a known issue with slackware+initbuntu and cannot be fixed.
