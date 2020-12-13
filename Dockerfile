FROM registry.opensuse.org/opensuse/tumbleweed:latest

RUN zypper -n install lynx wget jq npm10 p7zip-full patch
ADD bs-bashpatch.sh .
ADD patches patches

CMD ["/bin/bash", "bs-bashpatch.sh"]
