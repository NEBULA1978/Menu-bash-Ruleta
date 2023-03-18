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

# Secuencia de Fibonacci
fibonacci=(1 1)

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

# Función para simular la estrategia Inverse Fibonacci
inverse_fibonacci() {
  local resultado
  resultado=$(ruleta)
  if [[ $resultado == "$apuesta_al_par" ]]; then
    capital=$((capital + apuesta))
    fibonacci+=("$apuesta")
  else
    capital=$((capital - apuesta))
    if [[ ${#fibonacci[@]} -ge 2 ]]; then
      fibonacci=("${fibonacci[@]:0:${#fibonacci[@]}-2}")
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
jugada=0
while [[ $jugada -lt $numero_de_jugadas && ${#fibonacci[@]} -gt 0 ]]; do
  apuesta=${fibonacci[-1]}
  if [[ $capital -lt $apuesta ]]; then
    echo "No hay suficiente capital para seguir apostando. Capital actual: $capital"
    break
  fi

  inverse_fibonacci
  jugada=$((jugada + 1))
  echo "Jugada $jugada: Capital = $capital, Apuesta = $apuesta, Secuencia = ${fibonacci[*]}"
done

calcular_estadisticas
mostrar_estadisticas "Inverse Fibonacci"

# RESULTADO

# ./ruleta17.sh
# Ingrese el capital inicial: 1000
# ¿Desea apostar al par? (s/n): s
# Jugada 1: Capital = 1001, Apuesta = 1, Secuencia = 1 1 1
# Jugada 2: Capital = 1000, Apuesta = 1, Secuencia = 1
# Jugada 3: Capital = 999, Apuesta = 1, Secuencia = 1
# Jugada 4: Capital = 1000, Apuesta = 1, Secuencia = 1 1
# Jugada 5: Capital = 1001, Apuesta = 1, Secuencia = 1 1 1
# Jugada 6: Capital = 1002, Apuesta = 1, Secuencia = 1 1 1 1
# Jugada 7: Capital = 1003, Apuesta = 1, Secuencia = 1 1 1 1 1
# Jugada 8: Capital = 1002, Apuesta = 1, Secuencia = 1 1 1
# Jugada 9: Capital = 1001, Apuesta = 1, Secuencia = 1
# Jugada 10: Capital = 1002, Apuesta = 1, Secuencia = 1 1
# Jugada 11: Capital = 1003, Apuesta = 1, Secuencia = 1 1 1
# Jugada 12: Capital = 1002, Apuesta = 1, Secuencia = 1
# Jugada 13: Capital = 1003, Apuesta = 1, Secuencia = 1 1
# Jugada 14: Capital = 1002, Apuesta = 1, Secuencia = 
# Estrategia: Inverse Fibonacci
# Capital inicial: 1000
# Capital final: 1002
# Ganancia: 2
# Ganancia en porcentaje: 0%
# ----------------------------------