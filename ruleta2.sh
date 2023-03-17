#!/bin/bash

# Explicación de los operadores de comparación más comunes en Bash:

#     -eq: significa "igual a". Se utiliza para comparar si dos valores son iguales numéricamente.

#     -ne: significa "distinto de". Se utiliza para comparar si dos valores son diferentes numéricamente.

#     -lt: significa "menor que". Se utiliza para comparar si un valor es menor que otro numéricamente.

#     -le: significa "menor o igual que". Se utiliza para comparar si un valor es menor o igual que otro numéricamente.

#     -gt: significa "mayor que". Se utiliza para comparar si un valor es mayor que otro numéricamente.

#     -ge: significa "mayor o igual que". Se utiliza para comparar si un valor es mayor o igual que otro numéricamente.

# Estos operadores se pueden utilizar en combinación con las estructuras de control de flujo de Bash, como los condicionales if, para realizar acciones diferentes dependiendo del resultado de las comparaciones.


contador_respuesta_par=0
contador_respuesta_impar=0

echo "Bienvenido al juego de la ruleta."

read -p "Ingresa el dinero que quieres jugar: " dinero
dinero_inicial=$dinero

while true; do
    read -p "Quieres jugar a par (p) o impar (i)? " eleccion
    if [ $eleccion == "p" ]; then
        eleccion_texto="Par"
    elif [ $eleccion == "i" ]; then
        eleccion_texto="Impar"
    else
        echo "Opción inválida. Inténtalo de nuevo."
        continue
    fi

    read -p "Ingresa la cantidad que quieres apostar: " apuesta
    if [ $apuesta -le 0 ] || [ $apuesta -gt $dinero ]; then
        echo "Cantidad inválida. Inténtalo de nuevo."
        continue
    fi

    respuesta=$((RANDOM % 2))
    if [ $respuesta -eq 0 ]; then
        echo "Ha salido Par"
        ((contador_respuesta_par++))
        if [ $eleccion == "p" ]; then
            dinero=$((dinero + apuesta))
            echo "Has ganado. Tu dinero ahora es de $dinero."
            apuesta=$dinero_inicial
        else
            dinero=$((dinero - apuesta))
            echo "Has perdido. Tu dinero ahora es de $dinero."
            if [ $dinero -eq 0 ]; then
                echo "Te has quedado sin dinero. Fin del juego."
                break
            fi
            apuesta=$((apuesta * 2))
        fi
    else
        echo "Ha salido Impar"
        ((contador_respuesta_impar++))
        if [ $eleccion == "i" ]; then
            dinero=$((dinero + apuesta))
            echo "Has ganado. Tu dinero ahora es de $dinero."
            apuesta=$dinero_inicial
        else
            dinero=$((dinero - apuesta))
            echo "Has perdido. Tu dinero ahora es de $dinero."
            if [ $dinero -eq 0 ]; then
                echo "Te has quedado sin dinero. Fin del juego."
                break
            fi
            apuesta=$((apuesta * 2))
        fi
    fi
done

echo "Contador de respuestas:"
echo "Par: $contador_respuesta_par"
echo "Impar: $contador_respuesta_impar"

¡Claro! Puedes modificar el código para que el juego funcione como lo has descrito. Aquí te muestro cómo podrías hacerlo:

bash

contador_respuesta_par=0
contador_respuesta_impar=0

echo "Bienvenido al juego de la ruleta."

read -p "Ingresa el dinero que quieres jugar: " dinero
dinero_inicial=$dinero

while true; do
    read -p "Quieres jugar a par (p) o impar (i)? " eleccion
    if [ $eleccion == "p" ]; then
        eleccion_texto="Par"
    elif [ $eleccion == "i" ]; then
        eleccion_texto="Impar"
    else
        echo "Opción inválida. Inténtalo de nuevo."
        continue
    fi

    read -p "Ingresa la cantidad que quieres apostar: " apuesta
    if [ $apuesta -le 0 ] || [ $apuesta -gt $dinero ]; then
        echo "Cantidad inválida. Inténtalo de nuevo."
        continue
    fi

    respuesta=$((RANDOM % 2))
    if [ $respuesta -eq 0 ]; then
        echo "Ha salido Par"
        ((contador_respuesta_par++))
        if [ $eleccion == "p" ]; then
            dinero=$((dinero + apuesta))
            echo "Has ganado. Tu dinero ahora es de $dinero."
            apuesta=$dinero_inicial
        else
            dinero=$((dinero - apuesta))
            echo "Has perdido. Tu dinero ahora es de $dinero."
            if [ $dinero -eq 0 ]; then
                echo "Te has quedado sin dinero. Fin del juego."
                break
            fi
            apuesta=$((apuesta * 2))
        fi
    else
        echo "Ha salido Impar"
        ((contador_respuesta_impar++))
        if [ $eleccion == "i" ]; then
            dinero=$((dinero + apuesta))
            echo "Has ganado. Tu dinero ahora es de $dinero."
            apuesta=$dinero_inicial
        else
            dinero=$((dinero - apuesta))
            echo "Has perdido. Tu dinero ahora es de $dinero."
            if [ $dinero -eq 0 ]; then
                echo "Te has quedado sin dinero. Fin del juego."
                break
            fi
            apuesta=$((apuesta * 2))
        fi
    fi
done

echo "Contador de respuestas:"
echo "Par: $contador_respuesta_par"
echo "Impar: $contador_respuesta_impar"

# En este caso, hemos añadido varias características nuevas al juego:

#     Al inicio del juego, le preguntamos al usuario cuánto dinero quiere jugar y lo almacenamos en la variable dinero. También guardamos este valor en la variable dinero_inicial para poder volver a la apuesta inicial cuando ganamos.

#     Dentro del ciclo while, le pedimos al usuario que elija si quiere jugar a par o impar. Si elige una opción inválida, le pedimos que lo intente de nuevo. También le pedimos que ingrese la cantidad que quiere apostar. Si la cantidad es inválida, le pedimos que lo intente de nuevo.

#     Después de obtener la elección del usuario y la cantidad apostada, generamos un número aleatorio y comparamos si es par o impar. 