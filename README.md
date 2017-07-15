initbuntu
=========

A library/ubuntu based image that runs systemd instead of bash

---

This command works best for starting the image:

    docker run --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro -it --rm logandark/initbuntu
