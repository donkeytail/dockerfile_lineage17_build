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
	zlib1g-dev
	
RUN mkdir -p ~/bin && \
	mkdir -p ~/android/lineage 
	
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && \
	chmod a+x ~/bin/repo

# set PATH so it includes user's private bin if it exists
RUN if [ -d "$HOME/bin" ] ; then \
		PATH="$HOME/bin:$PATH"; \
	fi

RUN git config --global user.email $USER_EMAIL && \
	git config --global user.name $USER_NAME"

RUN cd ~/android/lineage \
	repo init -u https://github.com/LineageOS/android.git -b lineage-17.1
	
RUN repo sync

RUN source build/envsetup.sh && \
	breakfast ginkgo
