# base image
FROM ubuntu:24.04

# env settings
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
ENV TERMINFO_DIRS=/etc/terminfo:/lib/terminfo:/usr/share/terminfo

# update & install packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    curl \
    wget \
    git \
    zsh \
    sudo \
    tzdata \
    build-essential \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# timezone settings
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# create user
RUN useradd -m szkny && \
    echo "szkny:password" | chpasswd && \
    usermod -aG sudo szkny && \
    echo "szkny ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/szkny && \
    chmod 0440 /etc/sudoers.d/szkny

# custom settings
WORKDIR /home/szkny/
USER szkny
RUN /usr/bin/git clone https://github.com/szkny/dotfiles.git && \
    cp /home/szkny/dotfiles/zshrc /home/szkny/.zshrc && \
    /usr/bin/zsh /home/szkny/dotfiles/ubuntu_startup_script.zsh
RUN sudo chsh -s /usr/bin/zsh szkny

# start command
WORKDIR /home/szkny/
USER szkny
CMD ["/usr/bin/zsh"]
