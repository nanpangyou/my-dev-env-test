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

# 增加配置文件夹
RUN mkdir .config

# end

# zsh prezto
RUN zsh -c 'git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"' &&\
	zsh -c 'setopt EXTENDED_GLOB && for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"; done'


ENV SHELL /bin/zsh
# end


# tools 生成ssh key
RUN yes | pacman -S fzf openssh exa the_silver_searcher fd rsync &&\
	ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key &&\
	ssh-keygen -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key
# end


# add alias
ADD bashrc /root/.bashrc
RUN echo "[ -f /root/.bashrc ] && source /root/.bashrc" >> /root/.zshrc
# end




# z
# ADD .z_jump /root/.z_jump
RUN zsh -c 'git clone https://github.com/rupa/z.git /root/.z_jump'
# end


# dotfile
ADD z_jump_script /root/.config/z_jump_script
RUN echo "[ -f /root/.config/z_jump_script ] && source /root/.config/z_jump_script" >> /root/.zshrc
# end