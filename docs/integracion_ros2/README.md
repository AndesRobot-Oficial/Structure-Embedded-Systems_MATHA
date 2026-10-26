[← Inicio](../../README.md)

# Integración con ROS 2

```text
/cmd_vel → puente serial → ESP32 → control de ruedas
ESP32 → velocidades de ruedas y giro Z → puente → /wheel/odometry + /imu
/wheel/odometry + /imu → EKF → /odom
RPLIDAR → /scan
```

## Archivos

- [esp32_bridge.py](referencia/esp32_bridge.py): copia del nodo de traducción serial.
- [common.py](referencia/common.py): utilidad compartida importada por el nodo original.
- [ekf.yaml](config/ekf.yaml): fusión de vx, vy y velocidad angular odométrica con giro Z de IMU.
- [rplidar.yaml](config/rplidar.yaml): configuración de RPLIDAR A2M8.

Son copias de referencia del paquete `martha_nav`, no un paquete ROS instalable independiente. El puente conserva la importación `martha_nav.ros.common`; para ejecutarlo se necesita el paquete de origen y sus dependencias (`rclpy`, mensajes ROS, `std_srvs`, `pyserial`). EKF y LiDAR requieren `robot_localization` y `rplidar_ros`.

## Protocolo de esta copia

Serial a 115200 baudios, líneas terminadas en salto de línea. Velocidades lineales en m/s y angulares en rad/s.

| Dirección | Línea | Significado |
|---|---|---|
| PC → ESP32 | `cmd_vel,vx,vy,wz` | Orden de velocidad |
| PC → ESP32 | `reset` | Solicitud de rearme |
| ESP32 → PC | `odom,vx,vy,wz,gz` | Velocidad del cuerpo y giro de IMU |
| ESP32 → PC | `battery,V` | Medición de batería |
| ESP32 → PC | `ready` | Arranque o rearme aceptado |
| ESP32 → PC | `reset_blocked` | Rearme rechazado |
| ESP32 → PC | `motor_overcurrent`, `battery_too_low`, `cmd_vel_timeout`, `imu_missing` | Eventos |

El EKF integra la pose en el PC; la ESP32 reporta velocidades. El mensaje de IMU contiene giro Z, no orientación completa. El servicio de reset del puente informa del envío; el resultado del firmware llega por serial.

[Repositorio completo de navegación](https://github.com/Mocolax/martha_nav). Consultar allí la revisión que corresponda al robot antes de combinar software de distintas fechas.
