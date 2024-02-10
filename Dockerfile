FROM docker.io/fedora:39

ARG USERNAME

RUN dnf install --assumeyes make fish

RUN mkdir -p /tmp/
WORKDIR /tmp
COPY scripts/ /tmp/
COPY certs/ /usr/local/share/ca-certificates/
COPY ./makefile /tmp

# Install basic packages
RUN make \
    install-packages

# Azure Cli
RUN make \
    install-azcli

# CLI :)
RUN make \
    install-butane \
    install-sealed-secret \
    install-velero \
    install-openshift-cli \
    install-helm
    # update-ca-certificates

# Install Operator SDK
RUN make \
    install-operator-sdk

# DateTime
RUN rm -rf /etc/localtime \
    && ln -s /usr/share/zoneinfo/America/Montreal /etc/localtime

ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8

RUN make \
    add-user \
    setup-sudo-user \
    move-to-container-user-home

USER ${USERNAME}
WORKDIR /home/${USERNAME}

RUN make \
    install-fisher \
    install-fishtape \
    install-fish-fzf \
    install-fish-done \
    install-fish-tide-rainbow \
    setup-fish-env

RUN make \
    clean-up

ENTRYPOINT [ "fish", "-c" ]
CMD ["fish"]
