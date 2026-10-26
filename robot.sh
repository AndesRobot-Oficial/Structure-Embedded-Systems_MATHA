#!/bin/bash
# Martha FÍSICA — en el laptop de Martha (ESP32 de la base por USB).
#
#   ./robot.sh               levanta el contenedor con acceso a los USB (ESP32 y LiDAR)
#   ./robot.sh puertos       lista los puertos USB conectados (para docker/udev)
#   ./robot.sh serial        terminal serial con el ESP32: escribir "cmd_vel,0.1,0,0" y ver "odom,..."
#   ./robot.sh shell         terminal dentro del contenedor
#   ./robot.sh build         recompilar el workspace
#   ./robot.sh stop          apagar el contenedor
#
# Puerto del ESP32: por defecto /dev/martha_esp32 (ver docker/udev/README.md). Sin udev:
#   ESP32=/dev/ttyUSB0 ./robot.sh serial
set -e
# (Las líneas 2-12 de arriba son la ayuda que imprime "sed -n '2,12p'" si escribes una opción
#  que no existe. Los comentarios explicativos van desde aquí.)
#
# Todavía no hay launch de la base en ROS (andesrobot_bringup con ros2_control y el EKF): por eso
# ./robot.sh solo deja el contenedor listo. La base hoy se mueve con el puente serial de la tesis
# (ver docs/integracion_ros2/README.md).
#
# "set -e": si un comando falla, el script se detiene.
# Ir a la carpeta de este script y cargar las funciones comunes.
cd "$(dirname "$0")"
source docker/lib.sh

# Puerto serie del ESP32. ${ESP32:-/dev/martha_esp32} = usa la variable ESP32 si la escribiste
# antes del comando (ESP32=/dev/ttyUSB0 ./robot.sh serial); si no, el nombre fijo de udev.
ESP32="${ESP32:-/dev/martha_esp32}"

# Primer "case": opciones que NO necesitan el contenedor.
case "$1" in
  puertos)
    # Recorre todos los puertos serie USB conectados (ttyUSB = adaptadores tipo CP2102, como el
    # del ESP32 y el del RPLIDAR; ttyACM = placas con USB nativo) y muestra sus datos de fábrica
    # para las reglas udev.
    for d in /dev/ttyUSB* /dev/ttyACM*; do
      # Si no hay ninguno, el patrón queda literal ("/dev/ttyUSB*"): "-e" lo descarta.
      [ -e "$d" ] || continue
      echo "== $d"
      # udevadm muestra los atributos del dispositivo; grep -m3 se queda con los 3 primeros
      # idVendor / idProduct / serial (los que se copian en docker/udev/99-martha.rules).
      udevadm info -a -n "$d" | grep -m3 -E 'ATTRS\{(idVendor|idProduct|serial)\}'
    done
    # Si las reglas udev ya están instaladas, se ven los enlaces fijos.
    ls -l /dev/martha_esp32 /dev/martha_lidar 2>/dev/null || true
    exit 0 ;;
esac

# Desde aquí: modo robot (docker compose suma compose.robot.yaml = acceso a los USB).
martha_init robot
case "$1" in
  shell)  martha_need_running; exec $DC exec ros bash ;;
  build)  martha_need_running; exec $DC exec ros bash -ic 'cd /ros2_ws && colcon build --symlink-install' ;;
  stop)   $DC down; exit 0 ;;
  # Terminal serial con el ESP32 (miniterm de python3-serial, que viene en la imagen). Sirve para
  # la puesta en marcha sin ROS: lo que escribes va al ESP32 y lo que responde sale en pantalla.
  # Salir: Ctrl+].
  serial)
    [ -e "$ESP32" ] || { echo "[martha] No existe $ESP32. Revisa la conexión, ./robot.sh puertos, o usa ESP32=... ./robot.sh serial"; exit 1; }
    martha_running || martha_up
    exec $DC exec ros bash -ic "python3 -m serial.tools.miniterm --eol LF $ESP32 115200" ;;
  # Sin palabra: sigue abajo a levantar el contenedor.
  "") ;;
  # Opción desconocida: mostrar ayuda.
  *) sed -n '2,12p' "$0"; exit 1 ;;
esac

# Levantar el contenedor (con USB) y compilar si es la primera vez.
martha_up
echo
echo "[martha] Contenedor de Estructura listo, con acceso a los USB. Puertos fijos:"
ls -l /dev/martha_esp32 /dev/martha_lidar 2>/dev/null || echo "[martha]   (sin reglas udev todavía: ./robot.sh puertos y docker/udev/README.md)"
echo "[martha] Terminal serial con el ESP32:  ./robot.sh serial      Terminal ROS:  ./robot.sh shell"
