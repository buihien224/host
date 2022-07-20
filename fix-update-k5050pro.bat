@echo off
title VIETSUB INSTALL WITH KEY
cls
cd %cd%/firmware-update
type bless.txt
echo -------------------------------------------------
if %input%==1 (call:install) else (
	echo Wrong key && pause
	exit
) 


:install
echo.
set /p data="Do you want to format data {y/n} : "
echo -------------------------------------------------
echo.
echo "Enter Fastboot Mode then press any key to install"
pause
clse
echo -------------------------------------------------
fastboot.exe devices
fastboot.exe reboot bootloader
if %data%==y (
fastboot.exe erase metadata
fastboot.exe erase userdata 
)
fastboot.exe reboot fastboot
fastboot.exe flash system           system.img          || @echo "Flash system_ab error" 
fastboot.exe flash vendor           vendor.img          || @echo "Flash vendor_ab error" 
fastboot.exe flash product          product.img         || @echo "Flash product error" 
fastboot.exe flash odm              odm.img             || @echo "Flash odm error"
fastboot.exe reboot
type donate.txt
pause
exit