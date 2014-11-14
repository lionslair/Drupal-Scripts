#!/bin/bash

# from Gueno on stack exchange
# Get all Drupal sites
sites=`find . -maxdepth 1 -type d -print | grep -v '/all$' | grep -v '/default$' | grep -v '\.$'`

echo "Choose the commande to execute : "
echo "1. update"
echo "2. put sites offline"
echo "3. put sites online"
echo "4. clear all cache"
echo "5. clear css+js cache"
echo "6. clear specific cache"
echo "7. install specific module"
echo "8. disable specific module"
echo -n "Input [1,2,3,4,5,6,7 or 8] ? "
read choice

if [ $choice -gt 6 ] ; then
  echo -n "Extension (module/theme) name ?"
  read ext
fi

# For each site, execute the command
for site in $sites
do
  echo ----------
  echo $site
  cd $site  
  if [ $choice -eq 1 ] ; then
    drush updatedb
  elif [ $choice -eq 2 ] ; then
    drush vset --always-set maintenance_mode 1
  elif [ $choice -eq 3 ] ; then
    drush vset --always-set maintenance_mode 0
  elif [ $choice -eq 4 ] ; then
    drush cc all
  elif [ $choice -eq 5 ] ; then
    drush cc css+js
  elif [ $choice -eq 6 ] ; then
    drush cc
  elif [ $choice -eq 7 ] ; then
    drush pm-enable -y $ext
  elif [ $choice -eq 8 ] ; then
    drush pm-disable -y $ext
  fi
  cd ../
done
