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

# Solicitar secuencia de números al usuario
read -p "Ingrese la secuencia de números separados por espacios: " secuencia_numeros
secuencia=($secuencia_numeros)
numero_de_jugadas=100

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

# Función para simular la estrategia Inverse Labouchere
inverse_labouchere() {
  local resultado
  resultado=$(ruleta)
  if [[ $resultado == "$apuesta_al_par" ]]; then
    capital=$((capital + apuesta))
    secuencia+=($apuesta)
  else
    capital=$((capital - apuesta))
    secuencia=("${secuencia[@]:1}")
    if [ ${#secuencia[@]} -eq 0 ]; then
      secuencia+=($apuesta_base)
    fi
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
for ((i = 1; i <= numero_de_jugadas; i++)); do
  if [ ${#secuencia[@]} -eq 0 ]; then
    apuesta=$apuesta_base
  else
    apuesta=$((${secuencia[0]} + ${secuencia[-1]}))
  fi
  
  if [[ $capital -lt $apuesta ]]; then
    echo "No hay suficiente capital para seguir apostando. Capital actual: $capital"
    break
  fi

  inverse_labouchere
  echo "Jugada $i: Capital = $capital, Apuesta = $apuesta, Secuencia = ${secuencia[*]}"
done

calcular_estadisticas
mostrar_estadisticas "Inverse Labouchere"


# Este script simula la técnica Inverse Labouchere, en la que se basa en una secuencia de números ingresada por el usuario. La apuesta es igual a la suma del primer y último número de la secuencia. Si se gana, se agrega la apuesta al final de la secuencia; si se pierde, se elimina el primer número de la secuencia. Si la secuencia se vacía, se agrega el valor de la apuesta base.

# Los números que ingreses al principio en la secuencia de la técnica Inverse Labouchere afectarán la cantidad de tu apuesta y cómo evoluciona la secuencia a lo largo de las jugadas. Por lo general, los números deben ser positivos y tener en cuenta el capital inicial y los límites de la mesa de la ruleta.

# Una secuencia de inicio común es una serie de números pequeños como "1 2 3" o "1 2 2 1". Estas secuencias iniciales generarán apuestas más pequeñas al principio, lo que te permitirá jugar más tiempo y minimizar el riesgo de perder rápidamente todo tu capital.

# Recuerda que la técnica Inverse Labouchere, como cualquier otra estrategia de apuestas, no garantiza ganancias a largo plazo. La ruleta es un juego de azar y, a pesar de las estrategias que puedas aplicar, la ventaja siempre está del lado de la casa. Juega de manera responsable y ten en cuenta que el juego debe ser una actividad recreativa y no una fuente de ingresos.