BUILD_START=$(date +"%s");

# Colours
blue='\033[0;34m';
cyan='\033[0;36m';
yellow='\033[0;33m';
red='\033[0;31m';
nocol='\033[0m';

# Kernel details;
KERNEL_NAME="octopus";
VERSION="linaro";
DATE=$(date +"%d-%m-%Y-%I-%M");
DEVICE="Z00T";
OUT="msm8953";
FINAL_ZIP=$KERNEL_NAME-$VERSION-$DATE-$DEVICE.zip;

# Dirs
ANYKERNEL_DIR=$TRAVIS_BUILD_DIR/AnyKernel2;
KERNEL_IMG=$TRAVIS_BUILD_DIR/arch/arm64/boot/Image.gz-dtb;
UPLOAD_DIR=$TRAVIS_BUILD_DIR/$OUT;

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
find tmp_mod/ -name '*.ko' -type f -exec cp '{}' $ANYKERNEL_DIR/modules/system/lib/modules/ \;
cp $KERNEL_IMG $ANYKERNEL_DIR;
mkdir -p $UPLOAD_DIR;
cd $ANYKERNEL_DIR;
zip -r9 UPDATE-AnyKernel2.zip * -x README UPDATE-AnyKernel2.zip;
mv $ANYKERNEL_DIR/UPDATE-AnyKernel2.zip $UPLOAD_DIR/$FINAL_ZIP;

# Cleanup
rm $ANYKERNEL_DIR/Image.gz-dtb;

BUILD_END=$(date +"%s");
DIFF=$(($BUILD_END - $BUILD_START));
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol";
