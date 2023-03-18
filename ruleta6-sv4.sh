#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# //////////////////////////////////////////////
# //////////////////////////////////////////////
# Principio de funciones

function controlC() {
  # Parametro -e para que me aplique los saltos de linea
  echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n"
  # Codigo de estado no exitoso
  exit 1
}

# controlC
# Para capturr el atajo de teclado que acabo de escribir y redirijirlo a la funcion controlC
trap controlC INT

# Si no ccomento se ejecuta despues de 10 segundos
# sleep 10

#///////////////////////////////////////////
#///////////////////////////////////////////

function helpPanel() {
  # Hacemos mencion el nombre del script que estamos ejecutando con $0
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Uso:${endColour}${purpleColour} $0${endColour}\n"
  echo -e "\t${blueColour}-m)${endColour}${grayColour} Dinero con el que desea jugar${endColour}"
  echo -e "\t${blueColour}-t)${endColour} Tecnica de juego a utilizar${endColour}${purpleColour} (${endColour}${yellowColour}martingala${endColour}${blueColour}/${endColour}${yellowColour}inverseLabroucher${endColour}${purpleColour})${endColour}\n"
  tput cnorm
  exit 1
}

function martingala() {
  echo -e ""
  echo -e "\n[+] Dinero actual: $money"
  echo -ne "[+] ¿Cuánto dinero con el que tienes pensado apostar? -> " && read initial_bet
  echo -ne "[+] ¿Apostar a números pares o impares? (par/impar): " && read par_impar
  echo -e "\n\033[1;34m[+] Vamos a empezar con una cantidad incicial de $initial_bet€ a $par_impar\033[0m\n "

  # Para que cuando ganemos no apueste el doble,vale la apuesta inicial
  backup_bet=$initial_bet
  play_counter=1

  tput civis #Ocultamos el cursor
  while true; do
    money=$(($money - $initial_bet))
    echo -e "\n[+] Acabas de apostar $initial_bet€ y tienes $money€\n"
    random_number="$(($RANDOM % 37))"
    # echo -e "\n"
    echo -e "[+] Ha salido el numero: $random_number"

    sleep 2

    if [ ! "$money" -le 0 ]; then
      if [ "$par_impar" == "par" ]; then

        # Comprobamos si es par
        if [ "$(($random_number % 2))" -eq 0 ]; then
          # Anidamos y evitamos elif
          if [ "$random_number" -eq 0 ]; then
            echo -e "\n[+] Ha salido el 0 por tanto perdemos"
            initial_bet=$(($initial_bet*2))
            echo -e "[+]Ahora te quedas en $money€"
          else
            echo -e "[+] El numero que ha salido es Par , Ganas"
            reward=$(($initial_bet*2))
            echo -e "[+] Ganas un total de $reward€"
            money=$(($money + $reward))
            echo -e "[+] Tienes $money€"
            inital_bet=$backup_bet
          fi

        else
          echo -e "[+]El numero que ha salido es Impar , Pierdes"
          initial_bet=$(($initial_bet*2))
          echo -e "[+]Ahora te quedas en $money€"
        fi

        sleep 5

      fi
      else
        echo -e "\n[+]Te has quedado sin pasta\n"
        echo -e "[+]Han habido un total de $play_holder jugadas\n"
        exit 0
      fi

      let counter+=1
  done

  tput cnorm #Recuperamos el cursor
}

inverseLabroucher(){

  echo -e "[+] Dinero actual: $money€"
  # echo -ne "[+] ¿Cuánto dinero con el que tienes pensado apostar? -> " && read initial_bet
  echo -ne "[+] ¿Apostar a números pares o impares? (par/impar): " && read par_impar
  # echo -e "\n\033[1;34m[+] Vamos a empezar con una cantidad incicial de $initial_bet€ a $par_impar\033[0m\n "

  declare -a  my_secuencia=(1 2 3 4)

  echo -e "\n[+] Comenzamos con la secuencia [${my_secuencia[@]}]"

  bet=$((${my_secuencia[0]} + ${my_secuencia[-1]}))
  money=$(($money - $bet))

  unset my_secuencia[0]
  unset my_secuencia[-1]

  my_secuencia=(${my_secuencia[@]})

  echo -e "[+] Invertimos $bet€ y la secuencia se queda en  [${my_secuencia[@]}]"
  echo -e "\n"
  echo -e "\n[+] Tenemos tanto: $money€\n"

  tput civis
  while true; do
    random_number="$(($RANDOM % 37))"
    echo -e "[+] Ha salido el numero: $random_number\n"

    if [ "$par_impar" == "par" ]; then
      if [ "$(($random_number % 2))" -eq 0 ];then
        echo -e "[+] El numero es Par, Ganas"
        reward=$(($bet*2))
        let money+=$reward
        echo -e "\n[+] Tenemos tanto: $money€\n"
        my_secuencia+=[$bet]
        my_secuencia=[${my_secuencia[@]}]
        echo -e "\n[+] La nueva secuencia [${my_secuencia[@]}]"
      else
        echo -e "\n[+] El numero es Impar, !Pierdes!\n"

      fi
    fi

  sleep 2
  done

  tput cnorm
}

# //////////////////////////////////////////////
# //////////////////////////////////////////////
# FIN DE FUNCIONES

while getopts "m:t:h" arg; do
  case $arg in
  m) money=$OPTARG ;;
  t) technique=$OPTARG ;;
  # Cuando falle la opcion vamos a la  funcion panel de ayuda
  h) helpPanel ;;

  esac
done

# Estas dos variables tienen que tener contenido
if [ $money ] && [ $technique ]; then
  # echo "Voy a jugar con $money dinero usando la tecnica $technique"
  if [ "$technique" == "martingala" ]; then
    martingala
  elif [ "$technique" == "inverseLabroucher" ]; then
    inverseLabroucher
  else
    echo -e "\n${redColour}[!]${endColour}${grayColour} La técnica de juego no es valida${endColour}"
    helpPanel
  fi
else
  # Llamamos al panel de ayuda si me equivo al introducir parametros
  helpPanel
fi
