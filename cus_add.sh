#!/bin/bash

permis()
{
haa=$(find $1)
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
if [[ ! -f addon.img ]] ; then 
	echo "Download addon.img"
	sudo wget https://github.com/buihien224/host/raw/main/addon.img
fi

linkcute=$(ls *.zip)
if [[ -f $linkcute ]]; then
	echo "Phat hien $linkcute"
	sudo mkdir working custom
	sudo dd if=/dev/zero bs=1M count=256 >> addon.img
	sudo mount addon.img working
	echo "Giai nen $linkcute"
	cp $linkcute custom ; cd custom
	sudo jar xf $linkcute ; rm $linkcute
	cd ..
	echo "Copy file vao addon.img"
	sudo cp -rf custom/* working
	echo "Set quyen va SEcontest"
	permis working
	sudo umount working
	sudo rm -rf working custom
	sudo resize2fs -f -M addon.img 
	echo "Xong, hay copy file addon.img vao module/update"
fi

