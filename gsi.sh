#!/bin/sh

codename="picasso"
bhlnk="https://github.com/buihien224/host/raw/main/picasso.zip"
scpt="tmp/META-INF/com/google/android/updater-script"
user=$(whoami)
mod=0
#####
cd ~/
if [[ -d "output_picasso" ]]
then
echo "mk output folder"
else
mkdir output_picasso
fi
rm -r tmp
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
check ()
{
    if [[ -f "picasso.zip" ]]
    then
      echo "extracting template"
      unzip picasso.zip
    else
      echo "downloading template"
      wget -q $bhlnk 
         if [[ -f "picasso.zip" ]]
         then
           unzip picasso.zip
         else echo "report to @bhlnk"
         exit 1
         fi
     fi
}

comp ()
{
   if [[ -f "system.img" ]]
   then 
      if [[ -f "vendor.img" ]]
      then mod=2 
      else mod=1 
      fi
    else 
       echo " No image found" 
       exit 1
    fi

}

mksys()
{
    rm tmp/vendor_op_list
    echo -e "\e[1;33mGenerating system flashable\e[0m"
    systemsize=$(find "system.img" -printf "%s")
    echo -e "\e[1;33mCoping system.img...\e[0m"
    cp system.img tmp
    sed -i "s/test/$codename/g" $scpt 
    sed -i "s/160600/$systemsize/g" tmp/dynamic_partitions_op_list
    echo "set_progress(1.000000);" >> $scpt
    echo -e "\e[1;33mZipping........\e[0m"
    for dir in tmp; do
    ( cd "$dir" && zip -r ../"$gsi"_"$codename".zip . )
    done
    mv "$gsi"_"$codename".zip output_picasso
    rm -r tmp
    echo -e "\e[1;32mDone Flash "$gsi"_"$codename".zip\e[0m"
    echo -e "\e[1;32mIn Custom Recovery\e[0m"
    sleep 5
    exit 1
}

mkvendor()
{
    rm tmp/vendor_op_list
    echo -e "\e[1;33mGenerating system and vendor flashable\e[0m"
    systemsize=$(find "system.img" -printf "%s")
    vendorsize=$(find "vendor.img" -printf "%s")
    echo -e "\e[1;33mCoping system.img...\e[0m"
    cp system.img tmp
    echo -e "\e[1;33mCoping vendor.img...\e[0m"
    cp vendor.img tmp
    sed -i "s/test/$codename/g" $scpt 
    sed -i "s/160600/$systemsize/g" tmp/dynamic_partitions_op_list
    sed -i "s/010120/$vendorsize/g" tmp/vendor_op_list
    echo "assert(update_dynamic_partitions(package_extract_file("vendor_op_list")));
package_extract_file("vendor.img", map_partition("vendor"));" >> $scpt
    echo "set_progress(1.000000);" >> $scpt
    echo -e "\e[1;33mZipping........\e[0m"
    for dir in tmp; do
    ( cd "$dir" && zip -r ../"$gsi"_"$codename".zip . )
    done
    mv "$gsi"_"$codename".zip output_picasso
    rm -r tmp
    echo -e "\e[1;32mDone Flash "$gsi"_"$codename".zip\e[0m"
    echo -e "\e[1;32mIn Custom Recovery\e[0m"
    sleep 5
    exit 1

}
check
comp
if ( mod==0)
then
    echo ""
    echo -e "\e[1;31mCopy system.img to\e[0m"
    echo -e "\e[1;31m "$pwd"\e[0m"
    echo -e "\e[1;31mThen run this script again\e[0m"
    sleep 2
    exit 1
else 
    if (mod!=2)
    then mksys
    else mkvendor
    fi
fi

#####
