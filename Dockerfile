# FROM ubuntu
# FROM phusion/baseimage:0.9.16
FROM ubuntu:13.04
MAINTAINER Wojtek Majewski <jumski@gmail.com>

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y sudo
RUN locale-gen  en_US.UTF-8

RUN mkdir -p /home/jumski
RUN useradd jumski
RUN chown jumski /home/jumski

# allow for non-interactive sudo
RUN echo "jumski ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ADD . /home/jumski/dotfiles
WORKDIR /home/jumski/dotfiles

# RUN su -c "bin/skittle vim_from_source || (cat /home/jumski/.skittle/log/vim_from_source.log; exit 1)" jumski
# RUN su -c "bin/skittle install || (cat /home/jumski/.skittle/log/install.log; exit 1)" jumski

# clean after yourself
RUN apt-get clean && apt-get autoremove
