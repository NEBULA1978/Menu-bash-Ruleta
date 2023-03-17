# #!/bin/bash

# contador_respuesta_1=0
# contador_respuesta_2=0

# while true; do
#     respuesta=$((RANDOM % 2))
#     if [ $respuesta -eq 0 ]; then
#         echo "Respuesta 1"
#         ((contador_respuesta_1++))
#     else
#         echo "Respuesta 2"
#         ((contador_respuesta_2++))
#     fi

#     read -p "Presione Enter para continuar o escriba 'salir' para terminar: " opcion
#     if [[ "$opcion" == "salir" ]]; then
#         echo "Contador de respuestas:"
#         echo "Respuesta 1: $contador_respuesta_1"
#         echo "Respuesta 2: $contador_respuesta_2"
#         break
#     fi
# done


# Explicación de los operadores de comparación más comunes en Bash:

#     -eq: significa "igual a". Se utiliza para comparar si dos valores son iguales numéricamente.

#     -ne: significa "distinto de". Se utiliza para comparar si dos valores son diferentes numéricamente.

#     -lt: significa "menor que". Se utiliza para comparar si un valor es menor que otro numéricamente.

#     -le: significa "menor o igual que". Se utiliza para comparar si un valor es menor o igual que otro numéricamente.

#     -gt: significa "mayor que". Se utiliza para comparar si un valor es mayor que otro numéricamente.

#     -ge: significa "mayor o igual que". Se utiliza para comparar si un valor es mayor o igual que otro numéricamente.

# Estos operadores se pueden utilizar en combinación con las estructuras de control de flujo de Bash, como los condicionales if, para realizar acciones diferentes dependiendo del resultado de las comparaciones.

#!/bin/bash

contador_respuesta_1=0
contador_respuesta_2=0

while true; do
    respuesta=$((RANDOM % 2))
    if [ $respuesta -eq 0 ]; then
        echo "Respuesta 1"
        ((contador_respuesta_1++))
    else
        echo "Respuesta 2"
        ((contador_respuesta_2++))
    fi

    sleep $((RANDOM % 3)) # Espera entre 0 y 4 segundos antes de continuar

    opcion=$((RANDOM % 10))
    if [ $opcion -eq 0 ]; then
        echo "Saliendo del programa..."
        echo "Contador de respuestas:"
        echo "Respuesta 1: $contador_respuesta_1"
        echo "Respuesta 2: $contador_respuesta_2"
        break
    fi
done
# En este caso, el programa espera entre 0 y 4 segundos antes de mostrar la siguiente respuesta, y luego genera un número aleatorio entre 0 y 9 para determinar si el programa debe salir. Si el número generado es 0, el programa muestra los contadores y termina.

# Ten en cuenta que si quieres ajustar la duración de la espera o el intervalo de números aleatorios para la opción de salida, puedes cambiar los valores utilizados en las funciones sleep y RANDOM.