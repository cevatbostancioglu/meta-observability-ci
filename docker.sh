#!/usr/bin/env bash

set -o errexit  # stop on first error
set -o xtrace  # log every step
set -o nounset  # exit when script tries to use undeclared variables

echo "Syntax check started for $0. On any syntax error script will exit"
bash -n $0 # check and exit for syntax errors in script.
echo "Syntax is OK."

echo "running with ${USER}"

usage ()
{
    echo "usage"    
    exit 1
}


do_build_docker ()
{
    echo "do_build_docker start"

    docker build -t yoctodocker:yocto .

    echo "do_build_docker done"
}

do_shell_docker ()
{
    echo "do_shell_docker start"

    docker run -it --entrypoint /bin/bash \
     -v ${PWD}:/home/cevat \
     -v /media/cevat/ssd2t/build:/build \
     -e USER=${USER} \
     yoctodocker:yocto
    
    #docker run -it \
    #-v ${PWD}:/home/cevat \
    #-v /media/cevat/ssd2t/build:/build \
    # --name yoctodocker:yocto

    echo "do_shell_docker done"
}


# Process all commands.
while true ; do
    case "$1" in
        build)
            do_build_docker
            shift
            break
            ;;
        shell)
            do_shell_docker
            shift
            break
            ;;
        clean)
            do_clean
            shift
            break
            ;;
        *)
            if [[ -n $1 ]]; then
                echo "!!!!!!!!!!!Unknown build command " $1 "!!!!!!!!!!!!!"
                usage
            fi
            shift
            break
            ;;
    esac
done