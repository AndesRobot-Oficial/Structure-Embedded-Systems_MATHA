#!/bin/bash
# Martha SIN el robot (en tu PC): el modelo y las pruebas del repo de Estructura.
#
#   ./sim.sh                 el URDF de Martha en RViz, sin Gazebo (medidas, frames, torre)
#   ./sim.sh mecanum         igual, con las ruedas mecanum y sus rodillos (drive:=mecanum)
#   ./sim.sh pruebas         correr las pruebas (pytest) de los paquetes
#   ./sim.sh shell           terminal dentro del contenedor
#   ./sim.sh build           recompilar el workspace
#   ./sim.sh stop            apagar el contenedor
#   ./sim.sh cpu             igual que ./sim.sh pero sin GPU NVIDIA
#   ./sim.sh software        render por CPU (si RViz se ve NEGRO); más lento
#   ./sim.sh gpu             muestra con qué tarjeta está dibujando el contenedor
set -e
# (Las líneas 2-12 de arriba son la ayuda: el "sed -n '2,12p'" de más abajo las imprime
#  cuando escribes una opción que no existe. Por eso los comentarios explicativos van aquí.)
#
# Es el mismo esquema de milo_ws y del repo de Navegación: el código vive en tu PC (ros2_ws) y el
# contenedor lo ve como /ros2_ws. Editas en tu PC y compilas/corres dentro de Docker.
# La simulación en Gazebo (la casa RoboCup@Home, Nav2) está en el repo de Navegación.
#
# Ir a la carpeta donde está este script, aunque lo llames desde otra parte.
cd "$(dirname "$0")"
# Cargar las funciones comunes (martha_init, martha_up, martha_run...).
source docker/lib.sh
# Preparar docker compose en modo simulación. $1 = la primera palabra que escribiste
# (por ejemplo "cpu" o "software"); martha_init la usa para decidir GPU / CPU.
martha_init sim "$1"

# "case" = elegir qué hacer según la primera palabra ($1).
#   exec   = reemplazar este script por el comando (al salir del comando, termina todo)
#   ;;     = fin de esa opción
case "$1" in
  # Shell: una terminal bash dentro del contenedor.
  shell)  martha_need_running; exec $DC exec ros bash ;;
  # Build: recompilar ros2_ws (después de cambiar código en tu PC).
  build)  martha_need_running; exec $DC exec ros bash -ic 'cd /ros2_ws && colcon build --symlink-install' ;;
  # Pruebas: pytest de cada paquete que tenga carpeta test/.
  pruebas) martha_up
          exec $DC exec ros bash -ic 'cd /ros2_ws/src && for t in */test; do echo "== ${t%/test}"; (cd "${t%/test}" && python3 -m pytest -q test) || exit 1; done' ;;
  # Stop: apaga y borra el contenedor (tu código queda, está en tu PC).
  stop)   $DC down; exit 0 ;;
  # GPU: diagnóstico de con qué está dibujando OpenGL.
  gpu)    martha_need_running; martha_gpu_info; exit 0 ;;
  # Estas opciones siguen hacia abajo a abrir el modelo.
  ""|mecanum|cpu|software) ;;
  # Cualquier otra cosa: mostrar la ayuda (líneas 2 a 12 de este archivo) y salir con error.
  *) sed -n '2,12p' "$0"; exit 1 ;;
esac

# planar = ruedas fijas (como las usa la navegación); mecanum = ruedas con sus 12 rodillos.
DRIVE=planar
[ "$1" = "mecanum" ] && DRIVE=mecanum

# Levantar el contenedor y compilar si es la primera vez.
martha_up
echo
echo "[martha] Modelo de Martha en RViz (drive=$DRIVE)."
echo
# Ver andesrobot_description/launch/display.launch.py. Queda en primer plano: Ctrl+C lo detiene.
exec $DC exec ros bash -ic "ros2 launch andesrobot_description display.launch.py drive:=$DRIVE"
