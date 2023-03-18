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

# Variables de configuración
capital_inicial=1000
capital=$capital_inicial
apuesta_base=10
apuesta=$apuesta_base
numero_de_jugadas=100

# Función para simular una jugada en la ruleta
ruleta() {
  numero_aleatorio=$((RANDOM % 37))
  if [[ $numero_aleatorio -eq 0 ]]; then
    echo "verde"
  elif [[ $((numero_aleatorio % 2)) -eq 0 ]]; then
    echo "rojo"
  else
    echo "negro"
  fi
}

# Función para simular la estrategia Martingala
martingala() {
  local resultado
  resultado=$(ruleta)
  if [[ $resultado == "rojo" ]]; then
    capital=$((capital + apuesta))
    apuesta=$apuesta_base
  else
    capital=$((capital - apuesta))
    apuesta=$((apuesta * 2))
  fi
}

# Simulación de jugadas
for ((i = 1; i <= numero_de_jugadas; i++)); do
  if [[ $capital -lt $apuesta ]]; then
    echo "No hay suficiente capital para seguir apostando. Capital actual: $capital"
    break
  fi
  martingala
  echo "Jugada $i: Capital = $capital, Apuesta = $apuesta"
done

# Resultado final
ganancia=$((capital - capital_inicial))
echo "Resultado final: Capital inicial = $capital_inicial, Capital final = $capital, Ganancia = $ganancia"
