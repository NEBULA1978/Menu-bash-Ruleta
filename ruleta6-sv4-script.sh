#!/bin/bash

# VIRUS

# ganadas=0
# perdidas=0
# dineroGanado=0
# dineroPerdido=0

# mostrarEstadisticas() {
#   echo -e "\n[!] Saliendo..."
#   echo -e "Partidas ganadas: $ganadas (Dinero ganado: $dineroGanado€)"
#   echo -e "Partidas perdidas: $perdidas (Dinero perdido: $dineroPerdido€)"
# }

# inverseLabroucher() {
#   secuencia=(1 2 3 4)
#   dinero=$1

#   while [ $dinero -gt 0 ]; do
#     apuesta=$((${secuencia[0]} + ${secuencia[-1]}))
#     echo -e "\n[+] Nuestra nueva secuencia es ${secuencia[*]}"
#     echo -e "[+] Invertimos ${apuesta}€"

#     # Simulamos un número aleatorio entre 0 y 36
#     numero=$((RANDOM % 37))
#     echo -e "[+] Ha salido el numero: ${numero}"

#     if [ $((numero % 2)) -eq 0 ]; then
#       echo -e "[+] El numero es Par, Ganas"
#       dinero=$((dinero + apuesta))
#       secuencia=(${secuencia[@]:1} $((secuencia[-1] + 1)))
#       ganadas=$((ganadas + 1))
#       dineroGanado=$((dineroGanado + apuesta))
#     else
#       echo -e "[+] El número es impar, pierdes"
#       dinero=$((dinero - apuesta))
#       secuencia=(1 2 3 4)
#       perdidas=$((perdidas + 1))
#       dineroPerdido=$((dineroPerdido + apuesta))
#     fi

#     echo -e "[+] Tienes: ${dinero}€"
#   done
# }

# trap mostrarEstadisticas SIGINT SIGTERM

# inverseLabroucher 1000

#!/bin/bash

# ESTAN cambiadas las secuencias

ganadas=0
perdidas=0
dineroGanado=0
dineroPerdido=0
maxIteraciones=100

mostrarEstadisticas() {
  echo -e "\n[!] Saliendo..."
  echo -e "Partidas ganadas: $ganadas (Dinero ganado: $dineroGanado€)"
  echo -e "Partidas perdidas: $perdidas (Dinero perdido: $dineroPerdido€)"
}

inverseLabroucher() {
  secuencia=(1 2 3 4)
  dinero=$1
  iteracion=0

  while [ $dinero -gt 0 ] && [ $iteracion -lt $maxIteraciones ]; do
    apuesta=$((${secuencia[0]} + ${secuencia[-1]}))
    echo -e "\n[+] Nuestra nueva secuencia es ${secuencia[*]}"
    echo -e "[+] Invertimos ${apuesta}€"

    # Simulamos un número aleatorio entre 0 y 36
    numero=$((RANDOM % 37))
    echo -e "[+] Ha salido el numero: ${numero}"

    if [ $((numero % 2)) -eq 0 ]; then
      echo -e "[+] El numero es Par, Ganas"
      dinero=$((dinero + apuesta))
      secuencia=(${secuencia[@]:1} $((secuencia[-1] + 1)))
      ganadas=$((ganadas + 1))
      dineroGanado=$((dineroGanado + apuesta))
    else
      echo -e "[+] El número es impar, pierdes"
      dinero=$((dinero - apuesta))
      secuencia=(1 2 3 4)
      perdidas=$((perdidas + 1))
      dineroPerdido=$((dineroPerdido + apuesta))
    fi

    echo -e "[+] Tienes: ${dinero}€"
    iteracion=$((iteracion + 1))
  done
}

trap mostrarEstadisticas SIGINT SIGTERM

inverseLabroucher 1000
