#!/bin/bash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
#                                                                         *
# Ce programme secondaire sera téléchargé par les autres hôtes depuis un  *
# répertoire Github, sera lancé puis supprimé sans aucune intéraction.    *
#                                                                         *
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

NOW=$( date '+%F' )

echo -e "\nRécupération des données importantes, cette opération peut être longue..."

spin() {
  spinner='/|\\-/|\\-'
  while :
  do
    for i  in `seq 0 7`
    do 
      echo -n "${spinner:$i:1}"
      echo -en "\010"
      sleep 0.2
    done
  done
}
spin &
SPIN_ID=$!
disown

wget -q https://github.com/orlikoski/CyLR/releases/download/2.2.0/CyLR_linux-x64.zip
unzip CyLR_linux-x64.zip > /dev/null
rm -rf CyLR_linux-x64.zip
./CyLR -q -of "$NOW"_"$HOSTNAME"_CyLR.zip >/dev/null
curl -s --ftp-ssl --insecure -T "$NOW"_"$HOSTNAME"_CyLR.zip ftp://$Server:$ServerPort/$ServerRep/ --user $User:$Passwd
cd ./../../
rm -rf ./Temp_Expinfo_CyLR

printf '[\342\234\224] Récupération terminée.\n' | iconv -f UTF-8

kill -9 $SPIN_ID > /dev/null