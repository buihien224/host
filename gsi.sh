codename="picasso"
bhlnk="https://github.com/buihien224/host/raw/main/dynamic1.zip"
scpt="tmp/META-INF/com/google/android/updater-script"

#####
user=$(whoami)
cd ~/
pwd=$(pwd)
echo "Working dir : "$pwd""
echo ""
echo -e "\e[1;33mGenerate GSI Flashing Template @bhlnk \e[0m"
sleep 0.5
echo -e "\e[1;33mFor Dynamic Partition Device \e[0m"
sleep 0.5
echo -e "\e[1;32mEnter Gsi name \e[0m"
read gsi 
echo -e "\e[1;33mYour Device Is $codename and \e[0m"
sleep 0.5
######
if [[ -f "system.img" ]]
then
    echo -e "\e[1;33mGenerating..........\e[0m"
    systemsize=$(find "system.img" -printf "%s")
    echo "check if the template exists"
    if [[ -f "dynamic1.zip" ]]
    then
      echo "extracting template"
      unzip dynamic1.zip
    else
      echo "downloading template"
      wget -q $bhlnk 
         if [[ -f "dynamic1.zip" ]]
         then
           unzip dynamic1.zip
         else echo "report to @bhlnk"
         exit 1
         fi
     fi
    echo -e "\e[1;33mCoping system.img...\e[0m"
    cp system.img tmp
    sed -i "s/test/$codename/g" $scpt 
    sed -i "s/160600/$systemsize/g" tmp/dynamic_partitions_op_list
    echo -e "\e[1;33mDONE........\e[0m"
    for dir in tmp; do
    ( cd "$dir" && zip -r ../"$gsi"_"$codename".zip . )
    done
    echo -e "\e[1;32mDone Flash "$gsi"_"$codename".zip\e[0m"
    echo -e "\e[1;32mIn Custom Recovery\e[0m"
    
else 
echo
echo -e "\e[1;31mCopy system.img to\e[0m"
echo -e "\e[1;31m "$pwd"\e[0m"
echo -e "\e[1;31mThen run this script again\e[0m"
fi

#####
