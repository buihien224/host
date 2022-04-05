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


linkcute=$(ls *.zip)
if [[ -f $linkcute ]]; then
	mkdir working custom
	dd if=/dev/zero bs=1M count=256 >> addon.img
	sudo mount addon.img working
	cp $linkcute custom ; cd custom
	jar xf $linkcute ; rm $linkcute
	cd ..
	sudo cp -rf custom/* working
	permis working
	sudo umount working
	sudo rm -rf working custom
	resize2fs -f -M addon.img 
fi

