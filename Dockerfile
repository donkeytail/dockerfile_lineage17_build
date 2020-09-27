FROM ubuntu

ARG USER_EMAIL
ARG USER_NAME

ENV DEBIAN_FRONTEND noninteractive

# install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
	openjdk-11-jdk \
	android-sdk-platform-tools-common \
	android-tools-adb \
	android-tools-fastboot \
	bc \
	bison \
	build-essential \
	ccache \
	curl \
	flex \
	g++-multilib \
	gcc-multilib \
	git \
	gnupg \
	gperf \
	imagemagick \
	lib32ncurses5-dev \
	lib32readline-dev \
	lib32z1-dev \
	liblz4-tool \
	libncurses5 \
	libncurses5-dev \
	libsdl1.2-dev \
	libssl-dev \
	libxml2 \
	libxml2-utils \
	lzop \
	pngcrush \
	rsync \
	schedtool \
	squashfs-tools \
	xsltproc \
	zip \
	zlib1g-dev \
	# extra packages
        # for git-repo from google
        python \
        # for ps command
        procps \
        # no less on debian *gasp!*
        less \
        # so we have an editor inside the container
        vim \
        # has 'col' package needed for 'breakfast'
	bsdmainutils \
        # we can't build kernel on root (like docker runs)
        # we add these so we have a non-root user
        fakeroot \
	sudo 
	
RUN git config --global user.email $USER_EMAIL && \
	git config --global user.name $USER_NAME
	
RUN mkdir -p ~/bin && \
	mkdir -p ~/android/lineage 
	
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && \
	chmod a+x ~/bin/repo

ENV PATH $PATH:$HOME/bin

RUN cd ~/android/lineage && \
	repo init -u https://github.com/LineageOS/android.git -b lineage-17.1
	
RUN repo sync

RUN source build/envsetup.sh && \
	breakfast ginkgo
