#!/bin/bash

# Explicación de los operadores de comparación más comunes en Bash:

#     -eq: significa "igual a". Se utiliza para comparar si dos valores son iguales numéricamente.

#     -ne: significa "distinto de". Se utiliza para comparar si dos valores son diferentes numéricamente.

#     -lt: significa "menor que". Se utiliza para comparar si un valor es menor que otro numéricamente.

#     -le: significa "menor o igual que". Se utiliza para comparar si un valor es menor o igual que otro numéricamente.

#     -gt: significa "mayor que". Se utiliza para comparar si un valor es mayor que otro numéricamente.

#     -ge: significa "mayor o igual que". Se utiliza para comparar si un valor es mayor o igual que otro numéricamente.

# Estos operadores se pueden utilizar en combinación con las estructuras de control de flujo de Bash, como los condicionales if, para realizar acciones diferentes dependiendo del resultado de las comparaciones.

# ¿En qué consiste este segundo proyecto?

# Existen varias estrategias y técnicas que supuestamente se encargan de ‘vencer‘ a la ruleta de los casinos, alguna de ellas son las siguientes:

#     Martingala
#     D’Alembert
#     Secuencia de Fibonacci
#     Paroli
#     Óscar Grind
#     Guetting
#     Labouchere
#     Inverse Labouchere

# Hay muchas más, pero estas son las principales y las más comúnmente utilizadas. ¿Cuál es la idea?, como a nosotros nos encanta esto de buscarle las cosquillas a las cosas, vamos a programar 2 de las técnicas más comunes para ver si realmente son eficaces o si al final terminamos perdiendo todo nuestro dinero.

# Para ello tendremos que definir un sistema que nos permita controlar las pérdidas y las ganancias en Bash, haciendo uso para ello de Arrays entre otras cosas. Asimismo, tendremos que definir una lógica que nos permita simular jugadas, con el objetivo de que todo se acontezca de forma automática y nosotros como simples espectadores vayamos atendiendo a las estadísticas y a los resultados obtenidos.

# Va a estar muy interesante y obtendremos datos sorprendentes, ¿será que podemos vencer a la suerte?, ¡vamos a comprobarlo!

# La estrategia Oscar's Grind es una estrategia de apuestas que se utiliza comúnmente en juegos de casino como la ruleta. En esta estrategia, el jugador aumenta su apuesta después de cada victoria y mantiene la misma apuesta después de cada pérdida. El objetivo de la estrategia es ganar una unidad de apuesta después de cada ciclo de apuestas ganadoras y, finalmente, obtener una ganancia neta.

#!/bin/bash

# Solicitar capital inicial al usuario
read -p "Ingrese el capital inicial: " capital_inicial
capital=$capital_inicial

# Preguntar al usuario si desea apostar al par
read -p "¿Desea apostar al par? (s/n): " apostar_al_par
if [[ $apostar_al_par == "s" ]]; then
  apuesta_al_par="par"
else
  apuesta_al_par="rojo"
fi

# Variables de configuración
numero_de_jugadas=1000
apuesta_inicial=1
objetivo_de_ganancia=10

# Función para simular una jugada en la ruleta
ruleta() {
  numero_aleatorio=$((RANDOM % 37))
  if [[ $numero_aleatorio -eq 0 ]]; then
    echo "verde"
  elif [[ $((numero_aleatorio % 2)) -eq 0 ]]; then
    echo "par"
  else
    echo "impar"
  fi
}

# Función para simular la estrategia Oscar's Grind
oscars_grind() {
  local resultado
  resultado=$(ruleta)
  if [[ $resultado == "$apuesta_al_par" ]]; then
    capital=$((capital + apuesta))
    if [[ $capital -ge $objetivo_de_ganancia ]]; then
      apuesta=$apuesta_inicial
    else
      apuesta=$((apuesta + 1))
    fi
  else
    capital=$((capital - apuesta))
    apuesta=$apuesta_inicial
  fi
}

# Funciones para calcular y mostrar estadísticas
calcular_estadisticas() {
  ganancia=$((capital - capital_inicial))
  ganancia_porcentaje=$((ganancia * 100 / capital_inicial))
}

mostrar_estadisticas() {
  echo "Estrategia: $1"
  echo "Capital inicial: $capital_inicial"
  echo "Capital final: $capital"
  echo "Ganancia: $ganancia"
  echo "Ganancia en porcentaje: $ganancia_porcentaje%"
  echo "----------------------------------"
}

# Simulación de jugadas
jugada=0
apuesta=$apuesta_inicial
while [[ $jugada -lt $numero_de_jugadas && $capital -ge $apuesta ]]; do
  oscars_grind
  jugada=$((jugada + 1))
  echo "Jugada $jugada: Capital = $capital, Apuesta = $apuesta"
done

calcular_estadisticas
mostrar_estadisticas "Oscar's Grind"

# ./ruleta19.sh
# Ingrese el capital inicial: 10
# ¿Desea apostar al par? (s/n): s
# Jugada 1: Capital = 9, Apuesta = 1
# Jugada 2: Capital = 10, Apuesta = 1
# Jugada 3: Capital = 11, Apuesta = 1
# Jugada 4: Capital = 12, Apuesta = 1
# Jugada 5: Capital = 11, Apuesta = 1
# Jugada 6: Capital = 12, Apuesta = 1
# Jugada 7: Capital = 11, Apuesta = 1
# Jugada 8: Capital = 10, Apuesta = 1
# Jugada 9: Capital = 11, Apuesta = 1
# Jugada 10: Capital = 12, Apuesta = 1
# Jugada 11: Capital = 11, Apuesta = 1
# Jugada 12: Capital = 12, Apuesta = 1
# Jugada 13: Capital = 13, Apuesta = 1
# Jugada 14: Capital = 14, Apuesta = 1
# Jugada 15: Capital = 15, Apuesta = 1
# Jugada 16: Capital = 16, Apuesta = 1
# Jugada 17: Capital = 15, Apuesta = 1
# Jugada 18: Capital = 14, Apuesta = 1
# Jugada 19: Capital = 13, Apuesta = 1
# Jugada 20: Capital = 12, Apuesta = 1
# Jugada 21: Capital = 11, Apuesta = 1
# Jugada 22: Capital = 12, Apuesta = 1
# Jugada 23: Capital = 13, Apuesta = 1
# Jugada 24: Capital = 14, Apuesta = 1
# Jugada 25: Capital = 13, Apuesta = 1
# Jugada 26: Capital = 14, Apuesta = 1
# Jugada 27: Capital = 15, Apuesta = 1
# Jugada 28: Capital = 14, Apuesta = 1
# Jugada 29: Capital = 15, Apuesta = 1
# Jugada 30: Capital = 14, Apuesta = 1
# Jugada 31: Capital = 13, Apuesta = 1
# Jugada 32: Capital = 14, Apuesta = 1
# Jugada 33: Capital = 13, Apuesta = 1
# Jugada 34: Capital = 14, Apuesta = 1
# Jugada 35: Capital = 13, Apuesta = 1
# Jugada 36: Capital = 14, Apuesta = 1
# Jugada 37: Capital = 13, Apuesta = 1
# Jugada 38: Capital = 12, Apuesta = 1
# Jugada 39: Capital = 11, Apuesta = 1
# Jugada 40: Capital = 10, Apuesta = 1
# Jugada 41: Capital = 9, Apuesta = 1
# Jugada 42: Capital = 8, Apuesta = 1
# Jugada 43: Capital = 9, Apuesta = 2
# Jugada 44: Capital = 11, Apuesta = 1
# Jugada 45: Capital = 10, Apuesta = 1
# Jugada 46: Capital = 9, Apuesta = 1
# Jugada 47: Capital = 8, Apuesta = 1
# Jugada 48: Capital = 9, Apuesta = 2
# Jugada 49: Capital = 7, Apuesta = 1
# Jugada 50: Capital = 6, Apuesta = 1
# Jugada 51: Capital = 7, Apuesta = 2
# Jugada 52: Capital = 5, Apuesta = 1
# Jugada 53: Capital = 4, Apuesta = 1
# Jugada 54: Capital = 5, Apuesta = 2
# Jugada 55: Capital = 3, Apuesta = 1
# Jugada 56: Capital = 2, Apuesta = 1
# Jugada 57: Capital = 3, Apuesta = 2
# Jugada 58: Capital = 5, Apuesta = 3
# Jugada 59: Capital = 8, Apuesta = 4
# Jugada 60: Capital = 4, Apuesta = 1
# Jugada 61: Capital = 3, Apuesta = 1
# Jugada 62: Capital = 2, Apuesta = 1
# Jugada 63: Capital = 3, Apuesta = 2
# Jugada 64: Capital = 1, Apuesta = 1
# Jugada 65: Capital = 0, Apuesta = 1
# Estrategia: Oscar's Grind
# Capital inicial: 10
# Capital final: 0
# Ganancia: -10
# Ganancia en porcentaje: -100%
# ----------------------------------