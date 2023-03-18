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
read -p "Ingrese la secuencia de números separados por espacios: " -a secuencia

# Variables de configuración
numero_de_jugadas=1000

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
    secuencia+=("$apuesta")
  else
    capital=$((capital - apuesta))
    secuencia=("${secuencia[@]:1}")
    secuencia=("${secuencia[@]::${#secuencia[@]}-1}")
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
while [[ $jugada -lt $numero_de_jugadas && ${#secuencia[@]} -gt 0 ]]; do
  apuesta=$((${secuencia[0]} + ${secuencia[-1]}))
  if [[ $capital -lt $apuesta ]]; then
    echo "No hay suficiente capital para seguir apostando. Capital actual: $capital"
    break
  fi

  inverse_labouchere
  jugada=$((jugada + 1))
  echo "Jugada $jugada: Capital = $capital, Apuesta = $apuesta, Secuencia = ${secuencia[*]}"
done

calcular_estadisticas
mostrar_estadisticas "Inverse Labouchere"

# RESULTADO POR CONSOLA

# ./ruleta16.sh
# Ingrese el capital inicial: 10000000
# ¿Desea apostar al par? (s/n): s
# Ingrese la secuencia de números separados por espacios: 1 2 1 1
# Jugada 1: Capital = 10000002, Apuesta = 2, Secuencia = 1 2 1 1 2
# Jugada 2: Capital = 9999999, Apuesta = 3, Secuencia = 2 1 1
# Jugada 3: Capital = 10000002, Apuesta = 3, Secuencia = 2 1 1 3
# Jugada 4: Capital = 10000007, Apuesta = 5, Secuencia = 2 1 1 3 5
# Jugada 5: Capital = 10000014, Apuesta = 7, Secuencia = 2 1 1 3 5 7
# Jugada 6: Capital = 10000005, Apuesta = 9, Secuencia = 1 1 3 5
# Jugada 7: Capital = 10000011, Apuesta = 6, Secuencia = 1 1 3 5 6
# Jugada 8: Capital = 10000004, Apuesta = 7, Secuencia = 1 3 5
# Jugada 9: Capital = 10000010, Apuesta = 6, Secuencia = 1 3 5 6
# Jugada 10: Capital = 10000003, Apuesta = 7, Secuencia = 3 5
# Jugada 11: Capital = 9999995, Apuesta = 8, Secuencia = 
# Estrategia: Inverse Labouchere
# Capital inicial: 10000000
# Capital final: 9999995
# Ganancia: -5
# Ganancia en porcentaje: 0%
# ----------------------------------