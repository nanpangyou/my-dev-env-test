FROM archlinux:base-20230521.0.152478

ENV shell=/bin/bash

# 添加源
ADD mirrorlist /etc/pacman.d/mirrorlist

# 更新软件
RUN yes | pacman -Syu

WORKDIR /tmp