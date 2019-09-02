export CONFIG_FILE="$TRAVIS_BUILD_DIR/arch/arm64/octopus_defconfig"
export ARCH=arm64
export SUBARCH=arm64
export CROSS_COMPILE="./gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch64-linux-gnu-" ;
rm -rf out
mkdir -p out
JOBS="-j$(nproc --all)"
make O= $TRAVIS_BUILD_DIR/arch/arm64/configs/octopus_defconfig
make \
	O=${out_dir} \
	$JOBS
