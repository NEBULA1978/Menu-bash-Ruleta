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
        fi
    fi
done

echo "Contador de respuestas:"
echo "Par: $contador_respuesta_par"
echo "Impar: $contador_respuesta_impar"

echo "Resultados de las jugadas:"
echo "Jugadas: ${jugadas[*]}"
echo "Cantidad de pares: $(grep -o "0" <<< "${jugadas[*]}" | wc -l)"
echo "Cantidad de impares: $(grep -o "1" <<< "${jugadas[*]}" | wc -l)"

# RESULTADO POR CONSOLA

# next@next-System:~/Imágenes/Menu-bash-sarosi2$ ./ruleta5.sh
# Bienvenido al juego de la ruleta.
# Ingresa el dinero que quieres jugar: 1000
# Quieres jugar a par (p) o impar (i)? p
# Ha salido Impar
# Has perdido. Tu dinero ahora es de 980.
# Ha salido Impar
# Has perdido. Tu dinero ahora es de 940.
# Ha salido Impar
# Has perdido. Tu dinero ahora es de 860.
# Ha salido Par
# Has ganado. Tu dinero ahora es de 940.
# Ha salido Par
# Has ganado. Tu dinero ahora es de 950.
# Contador de respuestas:
# Par: 27
# Impar: 31
# Resultados de las jugadas:
# Jugadas: 1 1 1 1 1 1 0 0 0 0 1 1 0 1 1 0 0 1 1 0 0 0 1 1 1 1 0 0 1 1 0 1 1 0 0 0 1 1 0 1 1 0 1 1 0 1 1 1 1 0 1 1 1 1 0 1 1 0 1 1 1 1 0 0 0 1 1 0 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1 1 1 1
# Cantidad de pares: 27
# Cantidad de impares: 62
# next@next-System:~/Imágenes/Menu-bash-sarosi2$ 

# Por ejemplo, si la lista jugadas tiene los siguientes valores:

# 1 0 0 1 1 0 1

# Significa que en la primera jugada salió un número impar, en la segunda y tercera jugadas salieron números pares, en la cuarta y quinta jugadas salieron números impares, en la sexta jugada salió un número par y en la séptima jugada salió un número impar.