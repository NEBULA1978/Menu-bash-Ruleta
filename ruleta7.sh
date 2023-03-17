#!/bin/bash

# Explicación de los operadores de comparación más comunes en Bash:

#     -eq: significa "igual a". Se utiliza para comparar si dos valores son iguales numéricamente.

#     -ne: significa "distinto de". Se utiliza para comparar si dos valores son diferentes numéricamente.

#     -lt: significa "menor que". Se utiliza para comparar si un valor es menor que otro numéricamente.

#     -le: significa "menor o igual que". Se utiliza para comparar si un valor es menor o igual que otro numéricamente.

#     -gt: significa "mayor que". Se utiliza para comparar si un valor es mayor que otro numéricamente.

#     -ge: significa "mayor o igual que". Se utiliza para comparar si un valor es mayor o igual que otro numéricamente.

# Estos operadores se pueden utilizar en combinación con las estructuras de control de flujo de Bash, como los condicionales if, para realizar acciones diferentes dependiendo del resultado de las comparaciones.

jugadas=()
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

while [ $dinero -gt 0 ]; do
    respuesta=$((RANDOM % 2))
    jugadas+=($respuesta)
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
                break
            fi
        fi
    else
        echo "Ha salido Impar"
        ((contador_respuesta_impar++))
        jugadas+=($respuesta)
        if [ $eleccion == "i" ]; then
            dinero=$((dinero + apuesta))
            echo "Has ganado. Tu dinero ahora es de $dinero."
            apuesta=10
        else
            apuesta=$((apuesta * 2))
            dinero=$((dinero - apuesta))
            echo "Has perdido. Tu dinero ahora es de $dinero."
            if [ $dinero -eq 0 ]; then
                break
            fi
        fi
    fi
done

echo "Contador de respuestas:"
echo "Par: $contador_respuesta_par"
echo "Impar: $contador_respuesta_impar"

echo "Resultados de las jugadas:"
echo "Jugadas: ${jugadas[*]}"
for ((i=${#jugadas[@]}-1; i>=0; i--)); do
    if [ ${jugadas[$i]} -eq 0 ]; then
        echo "Jugada $((i+1)): Par"
    else
        echo "Jugada $((i+1)): Impar"
    fi
done | column -t
echo "Cantidad de pares: $(grep -o "0" <<< "${jugadas[*]}" | wc -l)"
echo "Cantidad de impares: $(grep -o "1" <<< "${jugadas[*]}" | wc -l)"
echo "Contador de respuestas:"
echo "Par: $contador_respuesta_par"
echo "Impar: $contador_respuesta_impar"
echo "Cantidad de jugadas ganadas: $((contador_respuesta_par + contador_respuesta_impar))"
echo "Cantidad de jugadas perdidas: $(( ${#jugadas[@]} - contador_respuesta_par - contador_respuesta_impar))"

# Este es un programa en Bash que simula un juego de ruleta. Algunas de las características del programa son:

#     Pide al usuario que ingrese la cantidad de dinero que quiere jugar.
#     Pide al usuario que elija si quiere jugar a par o impar.
#     Juega una serie de rondas de ruleta, mostrando el resultado (par o impar) de cada ronda y actualizando la cantidad de dinero del usuario según si ganó o perdió.
#     Cuando el usuario se queda sin dinero o decide terminar el juego, muestra el resultado final, incluyendo el número total de jugadas ganadas y perdidas, la cantidad de pares e impares, y una lista de todas las jugadas realizadas en orden inverso, indicando si cada una fue par o impar.

# Además, el programa utiliza algunos operadores de comparación en Bash (como -eq y -gt) para realizar comparaciones numéricas y tomar decisiones basadas en ellas. También utiliza algunas estructuras de control de flujo (como el bucle while y los condicionales if) para controlar el flujo del programa según el comportamiento del usuario y los resultados de las jugadas.