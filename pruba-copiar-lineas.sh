#!/bin/bash

#   echo "Instalar programa ?¿ introduce si o no"

#         echo -n "Instalar programa? [s/n]: "
#         read resultado

#         if [[ $resultado == [sS] ]]; then
#             echo "Instalando programa..."
#         elif [[ $resultado == [nN] ]]; then
#             echo "El programa no se va a instalar"
#         else
#             echo "Opcion invalida"
#         fi

contador_si=0
contador_no=0

while true; do
    echo -n "Instalar programa? [s/n]: "
    read resultado
    
    if [[ $resultado == [sS] ]]; then
        echo "Instalando programa..."
        ((contador_si++))
    elif [[ $resultado == [nN] ]]; then
        echo "El programa no se va a instalar"
        ((contador_no++))
    else
        echo "Opcion invalida"
    fi

    read -p "Presione Enter para continuar o escriba 'salir' para terminar: " opcion
    if [[ "$opcion" == "salir" ]]; then
        echo "Contador de respuestas:"
        echo "Si: $contador_si"
        echo "No: $contador_no"
        break
    fi
done

