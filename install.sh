#!/bin/bash

FILE='bf2-linuxded-1.5.3153.0-installer.sh';
URL='http://media1.gamefront.com/patches_scrolls/Battlefield2/bf2-linuxded-1.5.3153.0-installer.sh';
SHA256="b5afe6602280b99797b46389f3cd582bbfe212e7402c8b009b72e6ae41e8d435  $FILE";
ALTEREDSHA256="3ee58e4f490f3bd81f15796e6364441a16ebd3b03ad78b42649ddc6f397bdd08  $FILE";
ALREADYALTERED='n';

if [ ! -f $FILE ];
then
  echo -e "\nServer installer not found, downloading.";
  wget $URL;
fi

if [ ! -f $FILE ];
then
  echo -e "\nFile download failed. Exiting.";
  exit 1;
fi 

SHA256SUM=$(sha256sum $FILE);

if [[ $SHA256SUM != $SHA256 ]];
then 
  if [[ $SHA256SUM != $ALTEREDSHA256 ]];
  then
    echo -e "\nSHA256 sums mismatch! May need to redownload.";
    #TODO redownload
    exit 1;
  fi
fi

if [[ $SHA256SUM == $ALTEREDSHA256 ]];
then
  ALREADYALTERED='y'
fi

echo -e "\nInstaller located and verified. Patching installer.";

if [[ $ALREADYALTERED == 'n' ]];
then 
  patch -u $FILE data/installer.patch
fi

/bin/bash $FILE

if [[ $? != 0 ]];
then
  echo "Installation failed. Exiting.";
  exit 1;
fi

echo -e "Need sudo rights to add entry into /etc/hosts. Do you want an entry? [y/n]\nNote: You need this for the unlock server to work."
while true;
do
  read yn
  if [[ $yn == 'y' ]];
  then 
    sudo sh -c "/bin/echo -e '127.0.0.1\tbf2web.gamespy.com' >> /etc/hosts";
    echo -e 'Entry added.';
    echo -e 'Installation completed.';
    exit 0
  fi;
  if [[ $yn == 'n' ]];
  then 
    echo -e 'Installation completed.';
    exit 0
  fi;
  echo -e 'Try again [y/n]:'
done

exit 0;
