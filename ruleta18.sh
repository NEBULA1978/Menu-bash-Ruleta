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

# Función para simular la estrategia Paroli
paroli() {
  local resultado
  resultado=$(ruleta)
  if [[ $resultado == "$apuesta_al_par" ]]; then
    capital=$((capital + apuesta))
    apuesta=$((apuesta * 2))
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
  paroli
  jugada=$((jugada + 1))
  echo "Jugada $jugada: Capital = $capital, Apuesta = $apuesta"
done

calcular_estadisticas
mostrar_estadisticas "Paroli"

# En esta versión del código, se ha eliminado la solicitud de la secuencia de números al usuario y se ha establecido una apuesta inicial de 1. Además, se ha agregado la función paroli() para implementar la estrategia Paroli.

# En la función paroli(), la apuesta se duplica después de cada victoria y se restablece a la apuesta inicial después de cada pérdida. El bucle principal del script se ejecuta mientras el número de jugadas es menor que el número de jugadas especificado y el capital es suficiente para hacer la apuesta actual.

# En resumen, este script utiliza la estrategia Paroli en la ruleta y simula

# RESULTADO POR CONSOLA

# ./ruleta18.sh
# Ingrese el capital inicial: 10
# ¿Desea apostar al par? (s/n): s
# Jugada 1: Capital = 11, Apuesta = 2
# Jugada 2: Capital = 13, Apuesta = 4
# Jugada 3: Capital = 17, Apuesta = 8
# Jugada 4: Capital = 9, Apuesta = 1
# Jugada 5: Capital = 8, Apuesta = 1
# Jugada 6: Capital = 7, Apuesta = 1
# Jugada 7: Capital = 8, Apuesta = 2
# Jugada 8: Capital = 6, Apuesta = 1
# Jugada 9: Capital = 7, Apuesta = 2
# Jugada 10: Capital = 5, Apuesta = 1
# Jugada 11: Capital = 4, Apuesta = 1
# Jugada 12: Capital = 3, Apuesta = 1
# Jugada 13: Capital = 2, Apuesta = 1
# Jugada 14: Capital = 1, Apuesta = 1
# Jugada 15: Capital = 0, Apuesta = 1
# Estrategia: Paroli
# Capital inicial: 10
# Capital final: 0
# Ganancia: -10
# Ganancia en porcentaje: -100%
# ----------------------------------