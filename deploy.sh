#!/bin/bash

# Apagar NGINX
sudo systemctl stop nginx

# Apagar NGROK si está corriendo
killall ngrok

# Clonar el repositorio (asegurando que estás en el directorio correcto)
cd /var/www/webdevops
sudo git pull

# Encender NGINX
sudo systemctl start nginx

# Iniciar NGROK en segundo plano
sudo ngrok http 80 > /dev/null &
echo "NGROK iniciado."

# Esperar un momento para asegurar que ngrok se haya iniciado correctamente
sleep 2

# Obtener la URL de NGROK
ngrok_url=$(curl -s localhost:4040/api/tunnels | jq -r '.tunnels[0].public_url')
echo "La URL de NGROK es: $ngrok_url"

# Mantener el script en espera hasta que se interrumpa manualmente (Ctrl+C)
echo "Presiona Ctrl+C para salir y detener NGROK"
trap "killall ngrok" INT
sleep infinity
