export CONFIG_FILE="octopus_defconfig"
export ARCH=arm64
export SUBARCH=arm64
export CROSS_COMPILE="./gcc-arm-8.3-2019.03-x86_64-aarch64-linux-gnu/bin/aarch64-linux-gnu-" ;
rm -rf out
mkdir -p out
JOBS="-j$(nproc --all)"
make O= octopus_defconfig
make \
	O=${out_dir} \
	$JOBS
