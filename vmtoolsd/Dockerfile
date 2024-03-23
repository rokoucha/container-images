FROM registry.fedoraproject.org/fedora:39

RUN echo -e "fastestmirror=True\nmax_parallel_downloads=10" >> /etc/dnf/dnf.conf

RUN dnf install \
    --setopt=install_weak_deps=False \
    --setopt=tsflags=nodocs \
    -y \
    open-vm-tools \
    && dnf clean all

ENTRYPOINT ["/usr/bin/vmtoolsd"]
