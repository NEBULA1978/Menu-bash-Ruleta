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

    # sleep 2

    if [ ! "$money" -le 0 ]; then
      if [ "$par_impar" == "par" ]; then

        # Comprobamos si es par
        if [ "$(($random_number % 2))" -eq 0 ]; then
          # Anidamos y evitamos elif
          if [ "$random_number" -eq 0 ]; then
            echo -e "\n[+] Ha salido el 0 por tanto perdemos"
            initial_bet=$(($initial_bet * 2))
            echo -e "[+]Ahora te quedas en $money€"
          else
            echo -e "[+] El numero que ha salido es Par , Ganas"
            reward=$(($initial_bet * 2))
            echo -e "[+] Ganas un total de $reward€"
            money=$(($money + $reward))
            echo -e "[+] Tienes $money€"
            inital_bet=$backup_bet
          fi

        else
          echo -e "[+]El numero que ha salido es Impar , Pierdes"
          initial_bet=$(($initial_bet * 2))
          echo -e "[+]Ahora te quedas en $money€"
        fi

        # sleep 5

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

function inverseLabroucher() {
  echo -e "\n"
  echo -e "[+] Dinero actual: $money€"
  par_impar="par" # Puedes cambiar esto a "impar" si prefieres apostar a números impares
  echo -e "\n\033[1;34m[+] Vamos a empezar con una cantidad incicial de 5€ a $par_impar\033[0m\n "

  declare -a my_secuencia=(1 2 3 4)
  initial_bet=5
  win_count=0

  echo -e "\n[+] Comenzamos con la secuencia [${my_secuencia[@]}]"

  seq_index=0
  bet=$initial_bet
  money=$(($money - $bet))

  won_games=0
  lost_games=0

  tput civis
  while true; do
    random_number="$(($RANDOM % 37))"
    echo -e "[+] Ha salido el numero: $random_number"

    if [ "$par_impar" == "par" ] && [ "$random_number" -ne 0 ]; then
      if [ "$(($random_number % 2))" -eq 0 ]; then
        echo -e "[+] El numero es Par, Ganas"
        reward=$(($bet * 2))
        let money+=$reward
        echo -e "\n[+] Tienes: $money€\n"

        let win_count+=1
        let won_games+=1

        if [ $win_count -gt 1 ]; then
          my_secuencia[-1]=$((${my_secuencia[-1]} + ${my_secuencia[-2]}))
          unset my_secuencia[-2]
        else
          my_secuencia=(1 2 3 4)
        fi

        bet=${my_secuencia[0]}
        money=$(($money - $bet))

        echo -e "[+] Nuestra nueva secuencia es [${my_secuencia[@]}]"
        echo -e "[+] Invertimos $bet€"
      else
        echo -e "\n[+] El número es impar, pierdes\n"

        my_secuencia+=(${my_secuencia[-1]})
        my_secuencia+=(${my_secuencia[-2]})
        unset my_secuencia[-1]
        unset my_secuencia[-2]

        bet=$((${my_secuencia[0]} + ${my_secuencia[-1]}))
        money=$(($money - $bet))
        win_count=0
        let lost_games+=1

        echo -e "[+] Nuestra nueva secuencia es [${my_secuencia[@]}]"
        echo -e "[+] Invertimos $bet€"
      fi
    fi

    echo -e "Partidas ganadas: ${won_games}"
    echo -e "Partidas perdidas: ${lost_games}"

    if [ $money -ge 100 ]; then
      echo -e "\n[+] Has ganado 100€, ¡enhorabuena!\n"
      echo -e "[+] Partidas ganadas a $par_impar: ${won_games}"
      echo -e "[+] Partidas perdidas a $par_impar: ${lost_games}\n"
      break
    fi

    sleep 0.1
  done

  tput cnorm
}

# Con este código, después de cada victoria consecutiva, el último número de la secuencia se incrementará en 1 y la apuesta se ajustará en consecuencia. Por ejemplo, después de tres victorias consecutivas, la secuencia será [1 2 3 4 7] y la apuesta será de 8. Después de cuatro victorias consecutivas, la secuencia será [1 2 3 4 8] y la apuesta será de 9. Y así sucesivamente.

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

# Este código es un script de Bash que se encarga de ejecutar un juego de ruleta, utilizando dos técnicas de apuestas: Martingala e Inversa de Labouchere.

# Primero, el script define algunas variables de colores para la salida de texto en la consola, y luego define algunas funciones útiles, como una función para manejar la interrupción de control-c y una función para mostrar el panel de ayuda.

# Luego, hay dos funciones principales que implementan las dos técnicas de apuestas. La función martingala utiliza la estrategia Martingala, que implica duplicar la apuesta después de cada pérdida, y volver a la apuesta inicial después de cada victoria. La función inverseLabroucher utiliza la estrategia de apuestas inversa de Labouchere, que implica construir una secuencia de números y apostar la suma de los dos extremos después de cada pérdida, y eliminar los extremos de la secuencia después de cada victoria.

# El código principal del script procesa los argumentos de línea de comandos para obtener la cantidad de dinero con la que se desea jugar y la técnica de apuestas a utilizar, y luego llama a la función correspondiente para ejecutar el juego. Si no se proporcionan argumentos o se proporcionan argumentos incorrectos, se muestra el panel de ayuda.
