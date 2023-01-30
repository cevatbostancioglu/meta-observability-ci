FROM ubuntu:22.04
#python pylint3
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y gawk wget git-core diffstat unzip \
            texinfo gcc-multilib build-essential chrpath socat cpio  \
            python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping \
            python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev xterm liblz4-tool make zstd

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales bats jsonlint mesa-common-dev

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

RUN groupadd -g 1000 cevat \
            && useradd -u 1000 -g cevat -d /home/cevat cevat \
            && mkdir /home/cevat \
            && chown -R cevat:cevat /home/cevat

RUN mkdir -p /build
RUN chown -R cevat:cevat /build

USER cevat

WORKDIR /home/cevat

