[← Inicio](../README.md)

# Firmware ESP32 — copia de referencia

El sketch está en [firmware/firmware.ino](firmware/firmware.ino), junto a [control.h](firmware/control.h) y [sensors.h](firmware/sensors.h). La carpeta y el sketch se llaman `firmware`, como requiere Arduino.

Esta copia procede del checkout local `martha_nav`, revisión `e7993a90ace9e0272ac43eeeb9a4230fb19da2fe`. Se conserva sin alterar y **no se identifica como firmware final de las pruebas físicas**. Ver [diferencias](../docs/estado_y_pendientes.md).

## Funciones

- Cinemática directa e inversa de cuatro ruedas mecanum.
- PI por rueda con limitación de integral ante saturación.
- Encoders en cuadratura mediante PCNT y lectura de giro Z de MPU6050.
- Comandos seriales y reporte de velocidades a ROS 2.
- Timeout de comando y comprobaciones de batería/sobrecorriente en esta revisión.

## Parámetros de esta copia

| Parámetro | Valor |
|---|---|
| Radio de rueda | 0,075 m |
| lx + ly | 0,385 m |
| Cuentas por vuelta | 3200 |
| Kp / Ki | 2,0 / 1,6 |
| Signos de motores / encoders | Todos +1 |
| Límites de vx y vy / wz | 0,5 m/s / 1,2 rad/s |
| Control / reporte odométrico | 100 Hz / 50 Hz |
| Timeout | 500 ms |
| Serial | 115200 baudios |

## Preparar compilación

Abrir `firmware/firmware.ino` en Arduino IDE con soporte ESP32 compatible con `driver/pulse_cnt.h` y la API LEDC usada (Arduino-ESP32 3.x). La placa indicada en la documentación de origen es ESP32 DOIT DevKit V1. La versión exacta del core utilizada en las pruebas no está registrada aquí.

Si el core y la placa ya están instalados, desde la raíz del repositorio:

```bash
arduino-cli compile --fqbn esp32:esp32:esp32doit-devkit-v1 firmware/firmware
```

La compilación y carga física no se ejecutaron al organizar esta entrega. Antes de cargarlo, resolver la diferencia de protecciones y signos descrita en [puesta en marcha](../docs/puesta_en_marcha.md).
