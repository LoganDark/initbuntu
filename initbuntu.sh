#!/bin/bash

containerid="$(grep '/docker/' /proc/self/cgroup | tail -c 65 | head -c 64)"
readableid="$(echo -n \"$containerid\" | head -c 12)"
startsystemd='/bin/systemd --system --unit=basic.target'

systemdchoice='Continue with boot (start systemd)'
shellchoice='Choose a shell or program to start instead'
exitchoice='Exit (or press ^D)'
manualchoice='Enter path manually'

colorstart='\e[36m'
colorend='\e[39m'

color() {
    printf "%b$1%b" "$colorstart" "${@:2}" "$colorend"
}

color 'Welcome to initbuntu!

Run "docker exec -it %s bash" to obtain shell access to this container after systemd has been started.

Use "docker stop %s" to stop this container, or press ^P-^Q to detach from this container and let it run in the background.

Since stopping may take a while, "docker kill %s" will be faster.

\e[1mIF SYSTEMD COMPLAINS ABOUT CGROUP\e[22m, add \e[1m-v /sys/fs/cgroup:/sys/fs/cgroup:ro\e[22m as a flag, and systemd should stop complaining.

However, some systems are not capable of running this container. This cannot be prevented. Docker does not virtualize the whole system, so there will be incompatibilities.

Press any key for additional options, or wait 10 seconds to ignore' "$readableid" "$readableid" "$readableid"

if read -n 1 -p '' -s -t 10; then
    printf '

'

    select1=true
    while [[ "$select1" = true ]]; do
        select choice in "$systemdchoice" "$shellchoice" "$exitchoice"; do
            select1=true
            
            if [[ "$choice" = "$systemdchoice" ]]; then
                 exec $startsystemd
            elif [[ "$choice" = "$shellchoice" ]]; then
                select2=true
                
                while [[ "$select2" = true ]]; do
                    color '
Choose a shell to run.
'
                    select shell in `grep '^[^#]' /etc/shells` "$manualchoice"; do
                        select2=true

                        if [[ "$shell" = "$manualchoice" ]]; then
                            while [[ 1 ]]; do
                                color '
Path: '
                                
                                read -p '' path

                                if [[ -n "$path" ]]; then
                                    if [[ -x "$path" ]]; then
                                        printf '
'
                                        $path
                                        printf '
'
                                        break 3
                                    else
                                        color 'Not a valid executable program.
'
                                    fi
                                else
                                    break 2
                                fi
                            done
                        else
                            printf '
'
                            $shell
                            break 2
                        fi
                    done

                    select2=false
                done

                color '
Exiting.

'
            else
                color '
Exiting.

'
                exit
            fi
        done

        select1=false
    done

    color '
Exiting.

'
    exit
else
    printf '

'
    exec $startsystemd
fi

printf '

'
