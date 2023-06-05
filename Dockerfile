FROM archlinux:base-20230528.0.154326

ENV shell=/bin/bash

WORKDIR /tmp

# 添加源
ADD mirrorlist /etc/pacman.d/mirrorlist

# 更新软件
RUN yes | pacman -Syu

# 安装所需软件
RUN yes | pacman -S git vim htop which tree zsh curl 

# zsh
RUN zsh -c 'git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"' && \
 	zsh -c 'setopt EXTENDED_GLOB' &&\
	zsh -c 'for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done'
# end