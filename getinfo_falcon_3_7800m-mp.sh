#!/bin/bash
# language: potuguese pt-br
# escrito por cristiano nunes/ 2018
# postcristiano@gmail.com
# only debian-like distros


function instala() {

  apt-get update && apt-get install snmp -y 2> /dev/null > /dev/null
  echo "aplicacao SNMP instalada."
}

function freq() {
  echo " "
  snmpwalk -v3 -l authPriv -u $1 -a $2 -A "$3" -x $4 -X "$5" $6 -M $7 .1.3.6.1.4.1.290 | grep 290.3.5.1.2.2.1.1.0 | cut -d ":" -f2
  echo "------------------------------------------------------"
}

function uptim() {
  echo " "
  snmpwalk -v3 -l authPriv -u $1 -a $2 -A "$3" -x $4 -X "$5" $6 -M $7 .1.3.6.1.4.1.290 | grep 290.3.5.1.2.2.1.2.0 | cut -d ":" -f2
  echo "------------------------------------------------------"
}

function taxtrans() {
  echo " "
  snmpwalk -v3 -l authPriv -u $1 -a $2 -A "$3" -x $4 -X "$5" $6 -M $7 .1.3.6.1.4.1.290 | grep 290.3.5.1.2.2.1.26.0 | cut -d ":" -f2
  echo "------------------------------------------------------"
}

function vswr() {
  echo " "
  snmpwalk -v3 -l authPriv -u $1 -a $2 -A "$3" -x $4 -X "$5" $6 -M $7 .1.3.6.1.4.1.290 | grep 290.3.5.1.2.2.1.27.0 | cut -d ":" -f2
  echo "------------------------------------------------------"
}

function position() {
  echo " "
  snmpwalk -v3 -l authPriv -u $1 -a $2 -A "$3" -x $4 -X "$5" $6 -M $7 .1.3.6.1.4.1.290 | grep 290.3.5.1.3.1.[23].0 | cut -d ":" -f2
  echo "------------------------------------------------------"
}

function alti() {
  echo " "
  snmpwalk -v3 -l authPriv -u $1 -a $2 -A "$3" -x $4 -X "$5" $6 -M $7 .1.3.6.1.4.1.290 | grep 290.3.5.1.3.1.6.0 | cut -d ":" -f2
  echo "------------------------------------------------------"
}

function speed() {
  echo " "
  snmpwalk -v3 -l authPriv -u $1 -a $2 -A "$3" -x $4 -X "$5" $6 -M $7 .1.3.6.1.4.1.290 | grep 290.3.5.1.3.1.9.0 | cut -d ":" -f2
  echo "------------------------------------------------------"
}

function satel() {
  echo " "
  snmpwalk -v3 -l authPriv -u $1 -a $2 -A "$3" -x $4 -X "$5" $6 -M $7 .1.3.6.1.4.1.290 | grep 290.3.5.1.3.1.26.0 | cut -d ":" -f2
  echo "------------------------------------------------------"
}

function slop() {
  echo " "
  snmpwalk -v3 -l authPriv -u $1 -a $2 -A "$3" -x $4 -X "$5" $6 -M $7 .1.3.6.1.4.1.290 | grep 290.3.5.1.3.1.19.0 | cut -d ":" -f2
  echo "------------------------------------------------------"
}

function rodaprogram() {
  while true; do
  echo ">>> | INFO SNMP DO FALCON III 7800M-MP | <<<"
  echo "      ***executar script como root***"
  echo "------------------------------------------------------"
  echo "-> OPCOES DE UTILIZACAO: "
  echo "   [1] -> Ver frequencia que o radio esta operando (converter de hex string p/ texo) "
  echo "   [2] -> Ver a quanto tempo o radio esta ligado em segundos"
  echo "   [3] -> Ver taxa atual de transmissão de dados em Kb"
  echo "   [4] -> Ver VSWR do radio (converter de hex string p/ texo) "
  echo "   [5] -> Ver latitude e longitude da localizacao do radio em radianos"
  echo "   [6] -> Ver altitude em metros da localizacao do radio"
  echo "   [7] -> Ver velocidade de deslocamento do radio (em milhas Kph)"
  echo "   [8] -> Ver numero de satelites visiveis pelo radio"
  echo "   [9] -> Ver sleep time do GPS do radio. "
  tput setaf 1
  echo "   [10] -> Instalar o SNMP. Necessario para usar as opcoes anteriores."
  tput sgr 0
  echo "------------------------------------------------------"
  read -p "   Selecione uma opcao e click [ENTER]  "  opcao
  case $opcao in
    1 )
    tput setaf 3
    echo "A frequencia que o radio esta operando (converter de hex string p/ texo): "
    freq
    echo " "
    tput sgr 0
      ;;
    2 )
    tput setaf 3
    echo "O radio esta ligado há (em segundos): "
    uptim
    echo " "
    tput sgr 0
      ;;
    3 )
    tput setaf 3
    echo "A taxa de transmissão em Kilobits atualmente é: "
    taxtrans
    echo " "
    tput sgr 0
      ;;
    4 )
    tput setaf 3
    echo "O VSWR do rádio é (converter de hex string p/ texo): "
    vswr
    echo " "
    tput sgr 0
      ;;
    5 )
    tput setaf 3
    echo "A localização do equipamento rádio é: "
    position
    echo " "
    tput sgr 0
      ;;
    6 )
    tput setaf 3
    echo "A altitude do local que se encontra o radio é: "
    alti
    echo " "
    tput sgr 0
      ;;
    7 )
    tput setaf 3
    echo "A velocidade de deslocamento do radio é: "
    speed
    echo " "
    tput sgr 0
      ;;
    8 )
    tput setaf 3
    echo "Numero de satelites visiveis pelo radio é: "
    satel
    echo " "
    tput sgr 0
      ;;
    9 )
    tput setaf 3
    echo "O sleep time do GPS do radio é: "
    slop
    echo " "
    tput sgr 0
      ;;
    10 )
    instala
      ;;
  esac
  done
}

if [ $# -eq 0 ]; then
  echo ""
  echo "Digite os parametros para obter as informacoes de SNMPv3 do radio Harris Falcon III RF 7800M-MP. "
  echo " "
  echo "Rode o script como super usuario colocando os parametros na seguinte ordem:  "
  echo "7800mmp-snmp.sh <usuario> <prot_autent> <senha_autent> <prot_cript> <senha_cript> <end_ip_do_radio> <caminho_mibs> "
  echo " "
  echo "Exemplo de sintaxe: "
  echo "7800mmp-snmp.sh USER001 SHA senha123 AES senha123 10.10.60.50 /home/aluno/Downloads/MIBs/7800M-MP/"
  echo " "
  echo "*atencao nas letras maiusculas e minusculas. "
  echo "**utilize um espaço simples entre os parametros. "
elif [ $1 = "-h" ] || [ $1 = "--help" ] || [ $1 = "--ajuda" ] ; then
  echo "Rode o script como super usuario colocando os parametros na seguinte ordem:  "
  echo "7800mmp-snmp.sh <usuario> <prot_autent> <senha_autent> <prot_cript> <senha_cript> <end_ip_do_radio> <caminho_mibs> "
  echo " "
  echo "Exemplo de sintaxe: "
  echo "7800mmp-snmp.sh USER001 SHA senha123 AES senha123 10.10.60.50 /home/aluno/Downloads/MIBs/7800M-MP/"
  echo " "
  echo "*atencao nas letras maiusculas e minusculas. "
  echo "**utilize um espaço simples entre os parametros. "
else
  rodaprogram
fi
