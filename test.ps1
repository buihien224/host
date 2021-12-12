cd adb
type bless.txt
echo "- Go to Bootloader and Enter"
pause
./fastboot devices
sleep 2
echo "- Flash twrp ...."
./fastboot flash md1img rom/md1img.img
./fastboot flash spmfw rom/spmfw.img
./fastboot flash audio_dsp rom/audio_dsp.img
./fastboot flash pi_img rom/pi_img.img
./fastboot flash dpm rom/dpm.img
./fastboot flash scp rom/scp.img
./fastboot flash sspm rom/sspm.img
./fastboot flash mcupm rom/mcupm.img
./fastboot flash cam_vpu1 rom/cam_vpu1.img
./fastboot flash cam_vpu2 rom/cam_vpu2.img
./fastboot flash cam_vpu3 rom/cam_vpu3.img
./fastboot flash gz rom/gz.img
./fastboot flash lk rom/lk.img
./fastboot flash dtbo rom/dtbo.img
./fastboot flash tee rom/tee.img
./fastboot flash mitee rom/mitee.img
./fastboot flash boot rom/twrp.img
sleep 1
./fastboot reboot bootloader
sleep 10
echo "Wait .. Do Not Disconnect"
./fastboot reboot fastboot
sleep 1
./fastboot devices
./fastboot flash system rom/system.img
./fastboot flash vendor rom/vendor.img
./fastboot flash product rom/product.img
./fastboot flash system_ext rom/system_ext.img
./fastboot flash odm rom/odm.img
sleep 1
./fastboot reboot bootloader
sleep 1
./fastboot devices
./fastboot flash boot rom/boot.img
./fastboot flash cust rom/cust.img
sleep 3
./fastboot reboot
type donate.txt   
pause
