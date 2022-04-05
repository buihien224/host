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
if [[ -f addon.img ]] ; then 
	sudo rm addon.img
fi
	echo "Download addon.img"
	wget -q https://github.com/buihien224/host/releases/download/untagged-4f0d4cbb9220bf42b236/addon.img

linkcute=$(ls *.zip)
if [[ -f $linkcute ]]; then
	echo "Phat hien $linkcute"
	mkdir working custom
	sudo mount addon.img working
	echo "Giai nen $linkcute"
	cp $linkcute custom ; cd custom
	jar xf $linkcute ; rm $linkcute
	cd ..
	echo "Copy file vao addon.img"
	sudo cp -rf custom/* working/system
	echo "Set quyen va SEcontest"
	permis working
	sudo umount working
	rm -rf working custom
	echo "Xong, hay copy file addon.img vao module/update"
fi

