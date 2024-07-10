#!/bin/bash

# Ubicación del archivo con la lista de dominios
DOMAIN_LIST="dominios.txt"

# Verifica si sslscan está instalado
if ! command -v sslscan &> /dev/null
then
    echo "sslscan no está instalado. Instálelo antes de ejecutar este script."
    exit
fi

# Leer cada línea del archivo de dominios
while IFS= read -r domain
do
    echo "Analizando $domain..."
    # Ejecutar sslscan y guardar la salida
    output=$(sslscan --no-failed "$domain")

    # Filtrar y mostrar información específica
    echo "Reporte para $domain:"
    echo "-----------------------------------"
    # Detalles del certificado SSL
    echo "$output" | grep -E 'Signature Algorithm:|RSA Key Strength:'
    # Identidad del sitio y detalles del certificado
    echo "$output" | grep -E 'Subject:|Issuer:|Not valid before:|Not valid after:'
    echo "-----------------------------------"
    echo ""
done < "$DOMAIN_LIST"

echo "Análisis completado."
echo "Gracias por utilizar scripts by  Viernez13"
