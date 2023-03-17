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
        break
    elif [ $eleccion == "i" ]; then
        eleccion_texto="Impar"
        break
    else
        echo "Opción inválida. Inténtalo de nuevo."
    fi
done

apuesta=10

while true; do
    respuesta=$((RANDOM % 2))
    if [ $respuesta -eq 0 ]; then
        echo "Ha salido Par"
        ((contador_respuesta_par++))
        if [ $eleccion == "p" ]; then
            dinero=$((dinero + apuesta))
            echo "Has ganado. Tu dinero ahora es de $dinero."
            apuesta=10
        else
            apuesta=$((apuesta * 2))
            dinero=$((dinero - apuesta))
            echo "Has perdido. Tu dinero ahora es de $dinero."
            if [ $dinero -eq 0 ]; then
                echo "Te has quedado sin dinero. Fin del juego."
                break
            fi
        fi
    else
        echo "Ha salido Impar"
        ((contador_respuesta_impar++))
        apuesta=$((apuesta * 2))
        dinero=$((dinero - apuesta))
        echo "Has perdido. Tu dinero ahora es de $dinero."
        if [ $dinero -eq 0 ]; then
            echo "Te has quedado sin dinero. Fin del juego."
            break
        fi
    fi
done

echo "Contador de respuestas:"
echo "Par: $contador_respuesta_par"
echo "Impar: $contador_respuesta_impar"

# NO PARA CON -0

# En este caso, hemos incluido una pregunta al inicio del script que le permite al usuario elegir entre jugar a par o a impar. Si el usuario elige una opción inválida, se le pedirá que lo intente de nuevo. Si el usuario elige una opción válida, se establece la elección del usuario en la variable eleccion y se rompe el ciclo con break.

# Luego, el código sigue funcionando como en el ejemplo anterior. El usuario jugará siempre a la opción que haya elegido al comienzo del juego y siempre apostará el doble de su apuesta anterior cuando pierda. Esto seguirá sucediendo hasta que el usuario se quede sin dinero o decida salir del juego. Al final, se muestra el contador de respuestas para cada opción.