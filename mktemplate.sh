codename=$(getprop ro.product.device)
bhlnk="https://github.com/buihien224/host/raw/main/dynamic1.zip"
scpt="META-INF/com/google/android/updater-script"
#####
pkg install -y zip
cd storage/shared/Download
pwd=$(pwd)
echo -e "\e[1;31mGenerate GSI Flashing Template @bhlnk \e[0m"
sleep 0.5
echo -e "\e[1;31mFor Dynamic Partition Device \e[0m"
sleep 0.5
echo -e "\e[1;31mYour Device Is $codename \e[0m"
sleep 0.5
######
if [[ -f "system.img" ]]
then
    echo -e "\e[1;31mGenerating..........\e[0m"
    systemsize=$(find "system.img" -printf "%s")
    curl -o tmp.zip $bhlnk 
    unzip tmp.zip 
    rm tmp.zip
    echo -e "\e[1;31mCoping system.img...\e[0m"
    cp system.img tmp
    cd tmp
    sed -i "s/test/$codename/g" $scpt 
    sed -i "s/160600/$systemsize/g" dynamic_partitions_op_list
    echo -e "\e[1;31mDONE........\e[0m"
    for dir in */; do
    ( cd "$dir" && zip -r ../"$codename"_flashable.zip . )
    done
    rm tmp
    echo -e "\e[1;31mDone Flash "$codename"_flashable.zip\e[0m"
    echo -e "\e[1;31mIn Custom Recovery\e[0m"
    
else 
echo
echo -e "\e[1;31mCopy system.img to\e[0m"
echo -e "\e[1;31m/storage/emulated/0/Download\e[0m"
echo -e "\e[1;31mThen run this script again\e[0m"
fi

#####

