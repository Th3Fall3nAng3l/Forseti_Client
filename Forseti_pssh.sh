#!/bin/bash

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
#                                                                         *
# Ce programme secondaire sera téléchargé par les autres hôtes depuis un  *
# répertoire Github, sera lancé puis supprimé sans aucune intéraction.    *
#                                                                         *
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

User="freebox" #Nom d'utilisateur pour la connexion au SFTP

Passwd="7VF9hf64n!N79" #Mdp pour la connexion au SFTP

Server="cyber-lab.hd.free.fr"

ServerPort="22731"

ServerRep="FTP_EXPINFO/Forseti_DFIR/"

curl -s --ftp-ssl --insecure ftp://$Server:$ServerPort/FTP_EXPINFO/CyLR/CyLRLinux.zip -u $User:$Passwd --output CyLRLinux.zip
unzip CyLRLinux.zip > /dev/null
rm -rf CyLRLinux.zip
./CyLR -q -of "$HOSTNAME"_CyLR.zip >/dev/null
curl -s --ftp-ssl --insecure -T "$HOSTNAME"_CyLR.zip ftp://$Server:$ServerPort/$ServerRep/ --user $User:$Passwd
cd ./../../
rm -rf ./Temp_Expinfo