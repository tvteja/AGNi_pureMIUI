#!/bin/sh
export KERNELDIR=`readlink -f .`
. ~/WORKING_DIRECTORY/AGNi_stamp_CM.sh
#. ~/WORKING_DIRECTORY/gcc-4.9-uber_aarch64.sh
. ~/WORKING_DIRECTORY/gcc-6.x-uber_aarch64.sh
#. ~/WORKING_DIRECTORY/gcc-7.x-uber_aarch64.sh

echo ""
echo " Cross-compiling AGNi pureLOS-N kernel ..."
echo ""

cd $KERNELDIR/

if [ ! -f $KERNELDIR/.config ];
then
    make agni_mido-cmN_defconfig
fi

mv .git .git-halt
rm $KERNELDIR/arch/arm64/boot/dts/qcom/*.dtb
#rm $KERNELDIR/drivers/staging/prima/wlan.ko
make -j3 || exit 1
mv .git-halt .git

rm -rf $KERNELDIR/BUILT_mido-cmN
mkdir -p $KERNELDIR/BUILT_mido-cmN/
#mkdir -p $KERNELDIR/BUILT_mido-cmN/system/lib/modules/pronto

#find -name '*.ko' -exec mv -v {} $KERNELDIR/BUILT_mido-cmN/system/lib/modules/ \;
#mv $KERNELDIR/BUILT_mido-cmN/system/lib/modules/wlan.ko $KERNELDIR/BUILT_mido-cmN/system/lib/modules/pronto/pronto_wlan.ko

mv $KERNELDIR/arch/arm64/boot/Image.gz-dtb $KERNELDIR/BUILT_mido-cmN/

echo ""
echo "AGNi pureLOS-N has been built for mido !!!"

