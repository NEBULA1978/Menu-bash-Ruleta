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

# Este código te permite ingresar el dinero con el que deseas jugar y elegir si quieres jugar a par o a impar. Si pierdes, se aumenta tu apuesta y si ganas, se reinicia a la apuesta inicial. El juego termina cuando te quedas sin dinero.

# Además, al final del juego, se muestra el contador de respuestas para cada opción (par o impar) y se muestran los resultados de cada jugada, indicando si salió un número par o impar.