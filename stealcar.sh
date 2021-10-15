#!/bin/bash
#Colours
bold="\e[1m"
italic="\e[3m"
reset="\e[0m"
blink="\e[5m"
crayn="\e[36m"
yellow="\e[93m"
red="\e[31m"
black="\e[30m"
green="\e[92m"
redbg="\e[41m"
greenbg="\e[40m"


mkdir -p logs
#variables
msg="       Hack the Car like Watch Dogs"
inc="1"
log="carpunk"

read -p "Introduce el nombre de la interfaz con la que vas a sniffear: " i
read -p "Introduce el nombre del log (Por defecto en logs/carpunk): " log



banner(){
echo -e "${green}
  ██████ ▄▄▄█████▓▓█████ ▄▄▄       ██▓     ▄████▄   ▄▄▄       ██▀███
▒██    ▒ ▓  ██▒ ▓▒▓█   ▀▒████▄    ▓██▒    ▒██▀ ▀█  ▒████▄    ▓██ ▒ ██▒
░ ▓██▄   ▒ ▓██░ ▒░▒███  ▒██  ▀█▄  ▒██░    ▒▓█    ▄ ▒██  ▀█▄  ▓██ ░▄█ ▒
  ▒   ██▒░ ▓██▓ ░ ▒▓█  ▄░██▄▄▄▄██ ▒██░    ▒▓▓▄ ▄██▒░██▄▄▄▄██ ▒██▀▀█▄
▒██████▒▒  ▒██▒ ░ ░▒████▒▓█   ▓██▒░██████▒▒ ▓███▀ ░ ▓█   ▓██▒░██▓ ▒██▒
▒ ▒▓▒ ▒ ░  ▒ ░░   ░░ ▒░ ░▒▒   ▓▒█░░ ▒░▓  ░░ ░▒ ▒  ░ ▒▒   ▓▒█░░ ▒▓ ░▒▓░
░ ░▒  ░ ░    ░     ░ ░  ░ ▒   ▒▒ ░░ ░ ▒  ░  ░  ▒     ▒   ▒▒ ░  ░▒ ░ ▒░
░  ░  ░    ░         ░    ░   ▒     ░ ░   ░          ░   ▒     ░░   ░
      ░              ░  ░     ░  ░    ░  ░░ ░            ░  ░   ░
      ${greenbg}${green}<:Developed By Luijait:>${reset}
   $msg                                          
$green|──────────────────────────────────────|$reset
        "
}


trap ctrl_c INT

ctrl_c(){
   echo
   echo "Programa parado por el usuario"
   menu
}

menu(){
banner
echo -e " [1] Activa la interfaz CAN "
echo -e " [2] Desactivas interfaz CAN"
echo -e " [3] Empezar el Sniffeo"
echo -e " [4] Grabar Paquetes CAN"
echo -e " [5] Reproduce los paquetes CAN(Para abrirlo)"

echo -e " [0] Terminar programa"
read -p " [>] Elige: " option

if [[ $option = 1 || $option = 01 ]]
	then
        ip link set $i up
        msg="      La interfaz esta activa"
        clear
		menu

	elif [[ $option = 2 || $option = 02 ]]
	   then
	    ip link set $i down
        msg="     Se desactivo la interfaz"
        clear
		menu
        
    elif [[ $option = 3 || $option = 03 ]]
       then
         echo -e "${red}+${reset}------------------------------------${red}+${reset}"
         msg="       Happy Car Hacking"
         cansniffer $i -c
		 read -r -s -p $'Presiona ENTER para volver al menu'
         clear
		 menu
		 
	elif [[ $option = 4 || $option = 04 ]]
       then
         echo -e "${red}+${reset}------------------------------------${red}+${reset}"
         msg=" Paquetes grabados en $log$inc.log"
         candump -L $i >logs/$log$inc.log
         inc=$((inc+1))
         echo " >"
		 read -r -s -p $'Presiona ENTER para volver al menu.'
		 menu

    elif [[ $option = 5 || $option = 05 ]]
       then
         echo -e "${red}+${reset}------------------------------------${red}+${reset}"
         msg="    Ataque completado"
         read -p "[?]Introduce el nombre del log" logname
         canplayer -I logs/$logname
         clear
		 menu
		  	 
		 
	elif [[ $option = 0 || $option = 00 ]]
       then
         echo -e "[!]Terminando programa...${green}${reset}"
         exit 1
         
        else
		echo "Opcion invalida"
		sleep 1
        msg="   Opcion Incorrecta"
		clear
		menu
	fi	
}


menu

