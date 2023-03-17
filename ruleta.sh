#!/bin/bash

# Explicación de los operadores de comparación más comunes en Bash:

#     -eq: significa "igual a". Se utiliza para comparar si dos valores son iguales numéricamente.

#     -ne: significa "distinto de". Se utiliza para comparar si dos valores son diferentes numéricamente.

#     -lt: significa "menor que". Se utiliza para comparar si un valor es menor que otro numéricamente.

#     -le: significa "menor o igual que". Se utiliza para comparar si un valor es menor o igual que otro numéricamente.

#     -gt: significa "mayor que". Se utiliza para comparar si un valor es mayor que otro numéricamente.

#     -ge: significa "mayor o igual que". Se utiliza para comparar si un valor es mayor o igual que otro numéricamente.

# Estos operadores se pueden utilizar en combinación con las estructuras de control de flujo de Bash, como los condicionales if, para realizar acciones diferentes dependiendo del resultado de las comparaciones.


# contador_respuesta_par=0
# contador_respuesta_impar=0

# while true; do
#     respuesta=$((RANDOM % 2))
#     if [ $respuesta -eq 0 ]; then
#         echo "Par"
#         ((contador_respuesta_par++))
#     else
#         echo "Impar"
#         ((contador_respuesta_impar++))
#     fi

#     sleep $((RANDOM % 3)) # Espera entre 0 y 4 segundos antes de continuar

#     opcion=$((RANDOM % 10))
#     if [ $opcion -eq 0 ]; then
#         echo "Saliendo del programa..."
#         echo "Contador de respuestas:"
#         echo "Par: $contador_respuesta_par"
#         echo "Impar: $contador_respuesta_impar"
#         break
#     fi
# done

# En este caso, hemos renombrado los contadores y las respuestas para reflejar el juego de la ruleta que se describe. Además, hemos cambiado la lógica para que el contador de respuestas se incremente para pares o impares, en lugar de para respuestas 1 o 2. Con esto, ahora el programa imprimirá "Par" si el número generado es par y "Impar" si es impar. Al final del programa, se mostrará el contador de respuestas para cada caso.


# //////////////////////////////////////////////////////////////
# //////////////////////////////////////////////////////////////

contador_respuesta_par=0
contador_respuesta_impar=0

echo "Bienvenido al juego de la ruleta."
read -p "¿Cuántas jugadas quieres hacer? " num_jugadas

for (( i=1; i<=$num_jugadas; i++ )); do
    respuesta=$((RANDOM % 2))
    if [ $respuesta -eq 0 ]; then
        echo "Par"
        ((contador_respuesta_par++))
    else
        echo "Impar"
        ((contador_respuesta_impar++))
    fi

    sleep $((RANDOM % 3)) # Espera entre 0 y 4 segundos antes de continuar
done

echo "Fin del juego. Contador de respuestas:"
echo "Par: $contador_respuesta_par"
echo "Impar: $contador_respuesta_impar"
