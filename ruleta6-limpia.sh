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
  # tput cnorm
  exit 1
}

function martingala() {
  echo -e ""
  echo -e "\n[+] Dinero actual: $money"
  echo -ne "[+] ¿Cuánto dinero con el que tienes pensado apostar? -> " && read initial_bet
  echo -ne "[+] ¿Apostar a números pares o impares? (par/impar): " && read par_impar

  # Se guarda una copia de la apuesta inicial en backup_bet para usarla más adelante
  backup_bet=$initial_bet
  # Se inicializa el contador de jugadas a 0
  play_counter=0
  # Se inicializa el contador de victorias a 0
  win_counter=0
  # Se crea una cadena vacía para guardar las malas jugadas consecutivas que se vayan produciendo
  jugadas_malas=""
  # Se inicializa el contador de victorias de 100€ cuando se pierde todo el dinero a 0
  win_100_counter=0

  while true; do
    # Se incrementa el contador de jugadas al inicio de cada iteración del bucle
    play_counter=$((play_counter + 1))
    # Se resta el valor de la apuesta actual al dinero total
    money=$(($money - $initial_bet))

    # Se genera un número aleatorio entre 0 y 36 (37 valores posibles)
    random_number="$(($RANDOM % 37))"
    echo -e "\n"

    if [ ! "$money" -le 0 ]; then
      # Si se ha elegido apostar a números pares:
      if [ "$par_impar" == "par" ]; then
        # Si el número generado es par:
        if [ "$(($random_number % 2))" -eq 0 ]; then
          # Si el número generado es 0, se pierde la apuesta
          if [ "$random_number" -eq 0 ]; then
            # Se duplica el valor de la apuesta para la siguiente ronda
            initial_bet=$(($initial_bet * 2))
            # Se añade el número generado a la cadena de malas jugadas consecutivas
            jugadas_malas+=" $random_number"
          else
            # Se gana la apuesta y se recupera el valor de la apuesta inicial
            reward=$(($initial_bet * 2))
            money=$(($money + $reward))
            initial_bet=$backup_bet
            # Se vacía la cadena de malas jugadas consecutivas
            jugadas_malas=""
            # Si se han ganado 100€, se muestra un mensaje y se incrementa el contador de victorias
            if [ $money -ge $(($initial_bet + 100)) ]; then
              # echo -e "\n[+] ¡Has ganado 100€!\n"
              win_counter=$((win_counter + 1))
              if [ $money -eq $(($initial_bet + 100)) ]; then
                win_100_counter=$((win_100_counter + 1))
              fi
            fi
          fi
        else
          # Si el número generado es impar, se pierde la apuesta
          initial_bet=$(($initial_bet * 2))
          jugadas_malas+=" $random_number"
        fi
      # Si se ha elegido apostar a números impares:
      elif [ "$par_impar" == "impar" ]; then
        # Si el número generado es impar:
        if [ "$(($random_number % 2))" -ne 0 ]; then
          # Se gana la apuesta y se recupera el valor de la apuesta inicial
          reward=$(($initial_bet * 2))
          money=$(($money + $reward))
          initial_bet=$backup_bet
          # Se vacía la cadena de malas jugadas consecutivas
          jugadas_malas=""
          # Si se han ganado 100€, se muestra un mensaje y se incrementa el contador de victorias
          if [ $money -ge $(($initial_bet + 10)) ]; then
            # echo -e "\n[+] ¡Has ganado 100€!\n"
            win_counter=$((win_counter + 1))
            if [ $money -eq $(($initial_bet + 100)) ]; then
              win_10_counter=$((win_10_counter + 1))
            fi
          fi
        fi
      else
        # Si el número generado es impar, se pierde la apuesta
        initial_bet=$(($initial_bet * 2))
        jugadas_malas+=" $random_number"
      fi
      # Si se han perdido 6 apuestas consecutivas, se muestra un mensaje y se reinicia la apuesta inicial
      if [ "$(echo $jugadas_malas | wc -w)" -eq 6 ]; then
        # echo -e "\n[+] Has perdido 6 apuestas consecutivas, se reinicia la apuesta inicial\n"
        initial_bet=$backup_bet
        jugadas_malas=""
      fi
    # Si no queda dinero para apostar, se muestra un mensaje y se termina la función
    else
      echo -e "\n[+] Te has quedado sin pasta\n"
      echo -e "\n[+] Han habido un total de $play_counter jugadas\n"
      echo -e "\n[+] Has ganado 100€ $win_10_counter veces cuando has perdido todo el dinero\n"

      echo -e "\n[+] A continuación se van a mostrar las malas jugadas consecutivas que han salido\n"
      echo "$jugadas_malas"
      break
    fi
  done
}

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
  else
    echo -e "\n${redColour}[!]${endColour}${grayColour} La técnica de juego no es valida${endColour}"
    helpPanel
  fi
else
  # Llamamos al panel de ayuda si me equivo al introducir parametros
  helpPanel
fi


# El script es un programa de línea de comandos en Bash que simula un juego de ruleta en el que el usuario puede elegir la cantidad de dinero con la que desea jugar y la técnica de juego que desea utilizar (actualmente solo está disponible la martingala).

# La martingala es una técnica de juego en la que se duplica la apuesta cada vez que se pierde, con el objetivo de recuperar las pérdidas y obtener beneficios a largo plazo. En este caso, el usuario puede elegir apostar a números pares o impares.

# El programa utiliza un bucle while para simular las jugadas y va mostrando información al usuario a medida que se van produciendo, como el dinero actual, las apuestas realizadas, los números generados y las victorias y derrotas.

# Además, el programa también lleva un contador de las malas jugadas consecutivas que se van produciendo y, si se alcanza un número determinado (en este caso, 6), se reinicia la apuesta inicial.

# Al final del juego, se muestra al usuario información relevante como el número de jugadas, la cantidad de veces que se ha ganado 100€ cuando se ha perdido todo el dinero y las malas jugadas consecutivas que se han producido.