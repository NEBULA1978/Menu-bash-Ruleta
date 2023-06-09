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
for ((i = ${#jugadas[@]} - 1; i >= 0; i--)); do
    if [ ${jugadas[$i]} -eq 0 ]; then
        echo "Jugada $((i + 1)): Par"
    else
        echo "Jugada $((i + 1)): Impar"
    fi
done | column -t
echo "Cantidad de pares: $(grep -o "0" <<<"${jugadas[*]}" | wc -l)"
echo "Cantidad de impares: $(grep -o "1" <<<"${jugadas[*]}" | wc -l)"
echo "Contador de respuestas:"
echo "Par: $contador_respuesta_par"
echo "Impar: $contador_respuesta_impar"
echo "Cantidad de jugadas ganadas: $((contador_respuesta_par + contador_respuesta_impar))"
echo "Cantidad de jugadas perdidas: $((${#jugadas[@]} - contador_respuesta_par - contador_respuesta_impar))"

# Calcula el dinero total ganado y perdid

dinero_ganado=$((contador_respuesta_par * 10 + contador_respuesta_impar * 10))
dinero_perdido=$((dinero_inicial - dinero))

# Muestra el resultado final, incluyendo el dinero total ganado y perdido

# Por supuesto, para añadir el dinero de las jugadas ganadas y perdidas y el total final, puedes agregar las siguientes líneas de código al final del programa:
# Calcula el dinero total ganado y perdido

dinero_ganado=$((contador_respuesta_par * 10 + contador_respuesta_impar * 10))
dinero_perdido=$((dinero_inicial - dinero))
# Muestra el resultado final, incluyendo el dinero total ganado y perdido

echo "Resultado final:"
echo "Cantidad de jugadas ganadas: $contador_respuesta_par"
echo "Cantidad de jugadas perdidas: $((${#jugadas[@]} - contador_respuesta_par))"
echo "Dinero total ganado: $((contador_respuesta_par * 10))"
echo "Dinero total perdido: $((dinero_inicial - dinero))"
echo "Tu dinero final es de $dinero."

# //////////////////////////////////////////////////////////
# //////////////////////////////////////////////////////////

# Inicializar contadores y variables
declare -A contador
numeros_totales=0
rojo=0
negro=0
uno_dieciocho=0
diecinueve_treintayseis=0
par=0
impar=0
docenas=(0 0 0)
columnas=(0 0 0)

# Números rojos y negros en la ruleta
numeros_rojos=(1 3 5 7 9 12 14 16 18 19 21 23 25 27 30 32 34 36)
numeros_negros=(2 4 6 8 10 11 13 15 17 20 22 24 26 28 29 31 33 35)

function es_rojo() {
    for num in "${numeros_rojos[@]}"; do
        if [ "$1" -eq "$num" ]; then
            return 0
        fi
    done
    return 1
}

function es_negro() {
    for num in "${numeros_negros[@]}"; do
        if [ "$1" -eq "$num" ]; then
            return 0
        fi
    done
    return 1
}

function actualizar_contadores() {
    numero=$1
    ((contador[$numero]++))
    ((numeros_totales++))

    if es_rojo "$numero"; then
        ((rojo++))
    elif es_negro "$numero"; then
        ((negro++))
    fi

    if [ "$numero" -ge 1 ] && [ "$numero" -le 18 ]; then
        ((uno_dieciocho++))
    elif [ "$numero" -ge 19 ] && [ "$numero" -le 36 ]; then
        ((diecinueve_treintayseis++))
    fi

    if [ $((numero % 2)) -eq 0 ]; then
        ((par++))
    else
        ((impar++))
    fi

    if [ "$numero" -ge 1 ] && [ "$numero" -le 12 ]; then
        ((docenas[0]++))
    elif [ "$numero" -ge 13 ] && [ "$numero" -le 24 ]; then
        ((docenas[1]++))
    elif [ "$numero" -ge 25 ] && [ "$numero" -le 36 ]; then
        ((docenas[2]++))
    fi

    if [ $(( (numero - 1) % 3 )) -eq 0 ]; then
        ((columnas[0]++))
    elif [ $(( (numero - 2) % 3 )) -eq 0 ]; then
        ((columnas[1]++))
    elif [ $(( (numero - 3) % 3 )) -eq 0 ]; then
        ((columnas[2]++))
    fi
}

function mostrar_estadisticas() {
    echo "Estadísticas:"
    echo "  Rojo: $rojo"
    echo "  Negro: $negro"
    echo "  1-18: $uno_dieciocho"
    echo "  19-36: $diecinueve_treintayseis"
    echo "  Par: $par"
    echo "  Impar: $impar"
    echo "  Docenas:"
    echo "    1-12: ${docenas[0]}"
    echo "    13-24: ${docenas[1]}"
    echo "    25-36: ${docenas[2]}"
    echo "  Columnas:"
    echo "    1ra: ${columnas[0]}"
    echo "    2da: ${columnas[1]}"
    echo "    3ra: ${columnas[2]}"
}

# Bucle principal para ingresar números
while true; do
    read -p "Ingrese un número entre 0 y 36 (Ctrl+C para salir): " numero

    if [[ $numero =~ ^[0-9]+$ ]] && [ "$numero" -ge 0 ] && [ "$numero" -le 36 ]; then
        echo "Número ingresado: $numero"
        actualizar_contadores "$numero"
        mostrar_estadisticas
    else
        echo "Número inválido. Por favor, ingrese un número entre 0 y 36."
    fi
done

# Este es un programa en Bash que simula un juego de ruleta. El programa comienza pidiéndole al usuario que ingrese la cantidad de dinero que desea jugar y que elija si quiere jugar a par o impar.

# Luego, el programa juega una serie de rondas de ruleta, mostrando el resultado (par o impar) de cada ronda y actualizando la cantidad de dinero del usuario según si ganó o perdió. El programa utiliza varios operadores de comparación en Bash (como -eq y -gt) para realizar comparaciones numéricas y tomar decisiones basadas en ellas.

# Una vez que el usuario se queda sin dinero o decide terminar el juego, el programa muestra el resultado final, incluyendo el número total de jugadas ganadas y perdidas, la cantidad de pares e impares, y una lista de todas las jugadas realizadas en orden inverso, indicando si cada una fue par o impar.

# Además, el programa calcula el dinero total ganado y perdido y lo muestra junto con el resultado final. En general, es un buen ejemplo de cómo se puede utilizar Bash para crear programas útiles y entretenidos.