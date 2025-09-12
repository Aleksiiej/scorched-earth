FROM ubuntu:latest

RUN apt update && apt install -y \
    git \
    valgrind \
    clang-format \
    cmake \
    make \
    g++ \
    qt6-base-dev \
    qt6-declarative-dev \
    libxkbcommon-dev

COPY . /scorched-earth

WORKDIR /scorched-earth