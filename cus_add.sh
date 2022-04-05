#!/bin/bash

permis()
{
haa=$(sudo find $1)
		for i in $haa; do
			if [[ $i =~ "/bin/" ]]; then
				sudo chmod 755 $i 
				echo $i
			else 
				if [[ -d $i ]]; then
					sudo chmod 755 $i 
				elif [[ -f $i ]]; then
					sudo chmod 644 $i 
				fi
			fi
			sudo chcon u:object_r:system_file:s0 $i
			#ls -laZ $i
		done
		
}
if [[ -f addon.img ]] ; then 
	sudo rm addon.img
fi
	echo "Download addon.img"
	wget -q https://github.com/buihien224/host/raw/main/addon.img

linkcute=$(ls *.zip)
if [[ -f $linkcute ]]; then
	echo "Phat hien $linkcute"
	mkdir working custom
	dd if=/dev/zero bs=1M count=612 >> addon.img 
	e2fsck -f -y addon.img  > /dev/null 2>&1
	resize2fs addon.img > /dev/null 2>&1
	sudo mount addon.img working
	echo "Giai nen $linkcute"
	mv $linkcute custom ; cd custom
	jar xf $linkcute ; rm $linkcute
	cd ..
	echo "Copy file vao addon.img"
	sudo cp -rf custom/* working
	echo "Set quyen va SEcontest"
	permis working
	echo "Chay file sh tuy chinh"
	sh=$(ls *.sh)
	chmod +x $sh
	./$sh 
	cd ..
	sudo umount working
	resize2fs -f -M addon.img > /dev/null 2>&1
	rm -rf working custom
	echo "Xong, hay copy file addon.img vao module/update"
	
fi

