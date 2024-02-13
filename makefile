SHELL = /usr/bin/fish

# User settings
CONTAINER_USER = marbe020
CONTAINER_GROUP = secrole-unix-admin
CONTAINER_UID = 10286
CONTAINER_GID = 10000

# Velero Version
VELERO_VER = "1.12.2"

# Sealed Secret Version
SEALED_SECRETS_VER = "0.24.5"

# Go Version
GO_VER = "1.18.3"

#Operator SDK
OPERATOR_SDK_OC_VER = "4.10.46"
OPERATOR_SDK_VER = "1.16.0"

# Openshift Cli Version
OC_VER = "4.14"

# Helm Version
HELM_VERSION = "3.13.0"

# ETCD Cli Version
ETCD_VER=v3.5.12

# DUST Version
DUST_VER=v0.9.0


install-packages:
	rpm --import https://packages.microsoft.com/keys/microsoft.asc \
	&& dnf install --assumeyes https://packages.microsoft.com/config/rhel/9.0/packages-microsoft-prod.rpm \
	&& dnf install \
		--assumeyes \
		--setopt install_weak_deps=False \
		ansible \
		binutils \
		bind-utils \
		blktrace \
		bzip2 \
		ca-certificates \
		curl \
		ddrescue \
		diffutils \
		dnsmasq \
		duf \
		fatrace \
		fd-find \
		file \
		findutils \
		fio \
		gdb \
		git \
		golang \
		httpd \
		haproxy \
		hostname \
		htop \
		iftop \
		iptables \
		iotop \
		iperf \
		iproute \
		iputils \
		jq \
		lsof \
		man-db \
		net-tools \
		nginx \
		nmap \
		nmap-ncat \
		openssh-server \
		openssl \
		patch \
		procps-ng \
		psmisc \
		python3-gunicorn \
		python3-httpbin \
		python3-pygments \
		ripgrep \
		rsync \
		socat \
		strace \
		symlinks \
		tcpdump \
		telnet \
		unzip \
		vim \
		wget \
		wireshark-cli \
		fzf \
		bat \
		xz

add-user:
	groupadd \
		--gid ${CONTAINER_GID} \
		${CONTAINER_GROUP}
	adduser \
		--shell /usr/bin/fish \
		--gid ${CONTAINER_GID} \
		--uid ${CONTAINER_UID} \
		${CONTAINER_USER}

setup-sudo-user:
	echo ${CONTAINER_USER} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${CONTAINER_USER} \
	&& chmod 0440 /etc/sudoers.d/${CONTAINER_USER}

move-to-container-user-home:
	mv makefile /home/${CONTAINER_USER}/ \
	&& chown ${CONTAINER_USER}:${CONTAINER_GROUP} /home/${CONTAINER_USER}/makefile \
	&& printf "✅ makefile moved\n"

clean-up:
	sudo rm -rf /tmp/* \
	&& sudo dnf clean all \
	&& printf "✅ Cleanup completed\n"

install-dust:
	/tmp/dust.sh ${DUST_VER} \
	&& printf "✅ Dust installed\n"

install-etcd:
	/tmp/etcd.sh ${ETCD_VER} \
	&& printf "✅ ETCD installed\n"

install-butane:
	/tmp/butane.sh \
	&& printf "✅ Butane installed\n"

install-sealed-secret:
	/tmp/sealedsecret.sh ${SEALED_SECRETS_VER} \
	&& printf "✅ Sealed secret installed\n"

install-velero:
	/tmp/velero.sh ${VELERO_VER} \
	&& printf "✅ Velero client installed\n"

install-azcli:
	dnf install --assumeyes azure-cli \
	&& printf "✅ Azure cli installed\n"

install-operator-sdk:
	/tmp/operatorsdk.sh ${OPERATOR_SDK_OC_VER} ${OPERATOR_SDK_VER} \
	&& printf "✅ Openshift Operator SDK installed\n"

install-openshift-cli:
	/tmp/oc.sh ${OC_VER} \
	&& printf "✅ Openshift Client installed\n"

install-helm:
	/tmp/helm.sh ${HELM_VERSION} \
	&& printf "✅ Helm installed\n"

update-ca-certificates:
	/usr/sbin/update-ca-certificates \
	&& printf "✅ CA certificates updated\n"

install-fisher:
	curl -sL git.io/fisher \
    | source \
	&& fisher install jorgebucaran/fisher \
	&& printf "✅ fish fisher installed\n"

install-fishtape:
	fisher install jorgebucaran/fishtape \
	&& printf "✅ fish tape installed\n"

# Tide Classic
install-fish-tide-classic:
	fisher install IlanCosman/tide@v6 \
	&& tide configure --auto --style=Classic \
	--prompt_colors='True color' --classic_prompt_color=Dark \
	--show_time='24-hour format' --classic_prompt_separators=Slanted \
	--powerline_prompt_heads=Slanted --powerline_prompt_tails=Flat \
	--powerline_prompt_style='Two lines, character' --prompt_connection=Dotted \
	--powerline_right_prompt_frame=No --prompt_connection_andor_frame_color=Dark \
	--prompt_spacing=Compact --icons='Many icons' --transient=No \
	&& printf "✅ fish tide classic configured\n"

#Tide Rainbow
install-fish-tide-rainbow:
	fisher install IlanCosman/tide@v6 \
	&& tide configure --auto --style=Rainbow --prompt_colors='True color' \
	--show_time='24-hour format' --rainbow_prompt_separators=Angled \
	--powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat \
	--powerline_prompt_style='One line' --prompt_spacing=Compact \
	--icons='Many icons' --transient=No \
	&& printf "✅ fish tide rainbow configured\n"

install-fish-fzf:
	fisher install PatrickF1/fzf.fish \
	&& printf "✅ fish fzf installed\n"

install-fish-done:
	fisher install franciscolourenco/done \
	&& printf "✅ fish done installed\n"

setup-fish-env:
	oc completion fish > ~/.config/fish/completions/oc.fish \
	&& printf "✅ fish aliases moved\n"

build-user-docker:
	docker build . --tag ghcr.io/metabsd/toolbox-container:main --build-arg="USERNAME=${USER}"

run-user-docker:
	docker run --rm -d -it -v ${HOME}/git_projects:${HOME}/git_projects -w ${HOME} \
	-e TERM -e COLORTERM -e UPN=${EMAIL} --user (id -u):(id -u) \
	--name toolbox-${USER} ghcr.io/metabsd/toolbox-container:main \
	&& sleep 1 \
	&& docker exec -it toolbox-${USER} fish

exec-user-docker:
	docker exec -it toolbox-${USER} fish

kill-user-docker:
	docker kill toolbox-${USER}
