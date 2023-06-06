FROM archlinux:base-20230528.0.154326

ENV SHELL /bin/bash
ENV LANG=C.UTF-8

WORKDIR /

# 添加源
ADD mirrorlist /etc/pacman.d/mirrorlist

# 更新软件
RUN yes | pacman -Syu

# 安装所需软件
RUN yes | pacman -S git vim htop which tree curl zsh

# CMD echo $(which zsh)

# zsh prezto
RUN zsh -c 'git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"'
RUN zsh -c 'setopt EXTENDED_GLOB'
RUN zsh -c 'for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done'


ADD bashrc /root/.bashrc
RUN cat /root/.bashrc >> /root/.zshrc

ENV SHELL /bin/zsh
# end