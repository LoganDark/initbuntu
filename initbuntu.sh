printf '\e[36mWelcome to initbuntu!

Run "docker exec -it %s bash" to obtain shell access to this container.

Use "docker stop %s" to stop this container, or press ^P-^Q to detach from this container (leaving it running).

\e[1mIF SYSTEMD COMPLAINS ABOUT CGROUP\e[22m, add \e[1m-v /sys/fs/cgroup:/sys/fs/cgroup:ro\e[22m as a flag, and systemd should stop complaining.

However, some systems are not capable of running this container. This cannot be prevented. Docker does not virtualize the whole system, so there will be incompatibilities.\e[39m

' `hostname` `hostname`

read -n 1 -p "Press any key to continue boot, or press ^C to exit" -s

printf '

'
