#!/bin/bash

export CROSS_COMPILE=$(pwd)/toolchain/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-androidkernel-
export CC=$(pwd)/toolchain/clang/host/linux-x86/clang-r383902/bin/clang
export CLANG_TRIPLE=aarch64-linux-gnu-
export ARCH=arm64
export ANDROID_MAJOR_VERSION=t

export KCFLAGS=-w
export CONFIG_SECTION_MISMATCH_WARN_ONLY=y

make -C $(pwd) O=$(pwd)/out KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y physwizz_defconfig
make -C $(pwd) O=$(pwd)/out KCFLAGS=-w CONFIG_SECTION_MISMATCH_WARN_ONLY=y -j16

cp $(pwd)/out/arch/arm64/boot/Image /arch/arm64/boot/Image
cp ${{GITHUB_WORKSPACE}}/out/arch/arm64/boot/Image /arch/arm64/boot/Image

cp $(pwd)/out/arch/arm64/boot/Image ${{GITHUB_WORKSPACE}}/arm64/boot/Image
cp ${{GITHUB_WORKSPACE}}/out/arch/arm64/boot/Image ${{GITHUB_WORKSPACE}}/arch/arm64/boot/Image

pip install tl-bot
t-bot setup
