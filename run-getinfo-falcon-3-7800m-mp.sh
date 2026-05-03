#!/bin/bash
# lang pt-br
# author: postcristiano/2018
# only debian-like distro

# ==============================
# FUNÇÕES BASE
# ==============================

instala() {
  apt-get update > /dev/null 2>&1 && apt-get install snmp -y > /dev/null 2>&1
  echo "Aplicação SNMP instalada."
}

snmp_exec() {
  local oid="$1"
  snmpwalk -v3 -l authPriv \
    -u "$1_USER" -a "$2_AUTH" -A "$3_PASS" \
    -x "$4_PRIV" -X "$5_PRIV_PASS" \
    "$6_HOST" -M "$7_MIBS" "$oid"
}

get_value() {
  local oid="$1"
  local grep_filter="$2"

  echo " "
  snmpwalk -v3 -l authPriv \
    -u "$USER" -a "$AUTH" -A "$PASS" \
    -x "$PRIV" -X "$PRIV_PASS" \
    "$HOST" -M "$MIBS" .1.3.6.1.4.1.290 \
    | grep "$grep_filter" | cut -d ":" -f2

  echo "------------------------------------------------------"
}

# ==============================
# FUNÇÕES ESPECÍFICAS
# ==============================

freq()     { get_value ".1.3.6.1.4.1.290" "290.3.5.1.2.2.1.1.0"; }
uptim()    { get_value ".1.3.6.1.4.1.290" "290.3.5.1.2.2.1.2.0"; }
taxtrans() { get_value ".1.3.6.1.4.1.290" "290.3.5.1.2.2.1.26.0"; }
vswr()     { get_value ".1.3.6.1.4.1.290" "290.3.5.1.2.2.1.27.0"; }
position() { get_value ".1.3.6.1.4.1.290" "290.3.5.1.3.1.[23].0"; }
alti()     { get_value ".1.3.6.1.4.1.290" "290.3.5.1.3.1.6.0"; }
speed()    { get_value ".1.3.6.1.4.1.290" "290.3.5.1.3.1.9.0"; }
satel()    { get_value ".1.3.6.1.4.1.290" "290.3.5.1.3.1.26.0"; }
slop()     { get_value ".1.3.6.1.4.1.290" "290.3.5.1.3.1.19.0"; }

# ==============================
# MENU
# ==============================

rodaprogram() {
  while true; do
    clear
    echo ">>> | INFO SNMP DO FALCON III 7800M-MP | <<<"
    echo "      ***executar script como root***"
    echo "------------------------------------------------------"
    echo "-> OPCOES DE UTILIZACAO: "
    echo "   [1] Frequência"
    echo "   [2] Uptime"
    echo "   [3] Taxa de transmissão"
    echo "   [4] VSWR"
    echo "   [5] Latitude/Longitude"
    echo "   [6] Altitude"
    echo "   [7] Velocidade"
    echo "   [8] Satélites"
    echo "   [9] Sleep GPS"
    tput setaf 1
    echo "   [10] Instalar SNMP"
    tput sgr 0
    echo "------------------------------------------------------"

    read -rp "Selecione uma opcao: " opcao

    tput setaf 3

    case "$opcao" in
      1) echo "Frequência:"; freq ;;
      2) echo "Uptime (segundos):"; uptim ;;
      3) echo "Taxa de transmissão (Kb):"; taxtrans ;;
      4) echo "VSWR:"; vswr ;;
      5) echo "Localização:"; position ;;
      6) echo "Altitude (m):"; alti ;;
      7) echo "Velocidade:"; speed ;;
      8) echo "Satélites visíveis:"; satel ;;
      9) echo "Sleep GPS:"; slop ;;
      10) instala ;;
      *) echo "Opção inválida." ;;
    esac

    tput sgr 0
    echo ""
    read -rp "Pressione ENTER para continuar..."
  done
}

# ==============================
# VALIDAÇÃO DE PARÂMETROS
# ==============================

if [ $# -eq 0 ]; then
  echo ""
  echo "Uso:"
  echo "7800mmp-snmp.sh <usuario> <prot_autent> <senha_autent> <prot_cript> <senha_cript> <ip> <mibs>"
  echo ""
  echo "Exemplo:"
  echo "7800mmp-snmp.sh USER001 SHA senha123 AES senha123 10.10.60.50 /caminho/mibs"
  exit 1

elif [[ "$1" == "-h" || "$1" == "--help" || "$1" == "--ajuda" ]]; then
  echo "Mesma ajuda acima."
  exit 0
fi

# ==============================
# ATRIBUIÇÃO DE VARIÁVEIS
# ==============================

USER="$1"
AUTH="$2"
PASS="$3"
PRIV="$4"
PRIV_PASS="$5"
HOST="$6"
MIBS="$7"

# ==============================
# EXECUÇÃO
# ==============================

rodaprogram
