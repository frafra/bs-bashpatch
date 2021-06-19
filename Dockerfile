FROM registry.fedoraproject.org/fedora:34
LABEL org.opencontainers.image.source https://github.com/frafra/bs-patch

RUN dnf install -y lynx wget jq npm p7zip-plugins patch
ADD bs-bashpatch.sh .
ADD patches patches

CMD ["/bin/bash", "bs-bashpatch.sh"]
