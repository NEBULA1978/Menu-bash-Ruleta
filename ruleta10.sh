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
            apuesta=$((apuesta * 2))
            dinero=$((dinero - apuesta))
            echo "Has perdido. Tu dinero ahora es de $dinero."
            if [ $dinero -eq 0 ]; then
                break
            fi
            apuesta=10
        else
            dinero=$((dinero + apuesta))
            echo "Has ganado. Tu dinero ahora es de $dinero."
            apuesta=10
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
            apuesta=10
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



ganadas_consecutivas=0
ganancia_consecutiva=0
perdidas_consecutivas=0
perdida_consecutiva=0

for jugada in ${jugadas[@]}; do
    if [ $jugada -eq 0 ]; then
        ((ganadas_consecutivas++))
        ganancia_consecutiva=$((ganancia_consecutiva + apuesta))
        perdidas_consecutivas=0
    else
        ((perdidas_consecutivas++))
        perdida_consecutiva=$((perdida_consecutiva + apuesta))
        ganadas_consecutivas=0
    fi

    if [ $ganadas_consecutivas -eq 2 ]; then
        echo "Jugadas ganadas consecutivas: $ganadas_consecutivas - Ganancia: $ganancia_consecutiva"
        ganancias_consecutivas=$((ganancias_consecutivas + ganancia_consecutiva))
        ganancia_consecutiva=0
        ganadas_consecutivas=0
    fi

    if [ $perdidas_consecutivas -eq 2 ]; then
        echo "Jugadas perdidas consecutivas: $perdidas_consecutivas - Pérdida: $perdida_consecutiva"
        perdidas_consecutivas_totales=$((perdidas_consecutivas_totales + perdidas_consecutivas))
        perdida_consecutiva_total=$((perdida_consecutiva_total + perdida_consecutiva))
        perdida_consecutiva=0
        perdidas_consecutivas=0
    fi
done

if [ $ganancia_consecutiva -gt 0 ]; then
    echo "Jugadas ganadas consecutivas: $ganadas_consecutivas - Ganancia: $ganancia_consecutiva"
    ganancias_consecutivas=$((ganancias_consecutivas + ganancia_consecutiva))
fi

if [ $perdida_consecutiva -gt 0 ]; then
    echo "Jugadas perdidas consecutivas: $perdidas_consecutivas - Pérdida: $perdida_consecutiva"
    perdidas_consecutivas_totales=$((perdidas_consecutivas_totales + perdidas_consecutivas))
    perdida_consecutiva_total=$((perdida_consecutiva_total + perdida_consecutiva))
fi

echo "Total de jugadas ganadas consecutivas: $ganancias_consecutivas"
echo "Total de jugadas perdidas consecutivas: $perdidas_consecutivas_totales"
