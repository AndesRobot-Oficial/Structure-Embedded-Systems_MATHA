[← Inicio](../README.md)

# Firmware ESP32

El sketch está en [firmware.ino](firmware.ino), junto a [control.h](control.h) y [sensors.h](sensors.h).
La carpeta y el sketch se llaman `firmware`, como requiere Arduino.

Es la revisión que **funciona hoy en Martha**: la del repo de la tesis `martha_nav` en el commit
`c8faa84605207ce6f4ebea11acf5fcea83ed4580` (21 de octubre de 2026), con la que pasó la puesta en
marcha (cada eje dentro del 1 %, un escalón de 0,2 m/s en 0,12 s con 4 % de sobrepaso, el
giroscopio igual a las ruedas en un giro) y con la que se mapeó y se navegó en el robot real.
Reemplaza la copia anterior (`e7993a9`), que tenía otros signos, otra Kp y otros límites.

## Funciones

- Cinemática directa e inversa de cuatro ruedas mecanum.
- PI por rueda **sobre un feedforward** (RPM ≈ 1,15 · (PWM − 4), medido en las cuatro ruedas),
  con limitación de integral ante saturación.
- Motores en **slow decay** (una entrada en alto y el PWM invertido en la otra: manejar y frenar).
  En fast decay los motores no arrancaban por debajo de PWM ~130.
- Encoders en cuadratura con PCNT y giro Z del MPU6050 (la IMU va montada de lado: el giro del
  robot sale del eje X del sensor, registro `0x43`).
- Comandos seriales y reporte de velocidades a ROS 2 (protocolo en
  [integración ROS 2](../docs/integracion_ros2/README.md)).
- Timeout de comando de 500 ms: si no llega `cmd_vel`, las ruedas se detienen.

## Parámetros de esta revisión

| Parámetro | Valor |
|---|---|
| Radio de rueda | 0,075 m |
| lx + ly | 0,385 m |
| Cuentas por vuelta | 3200 (64 CPR × 50:1) |
| Kp / Ki | 1,0 / 1,6 (sobre el feedforward) |
| Signos de motores (FL, FR, RL, RR) | +1, −1, +1, −1 |
| Signos de encoders (FL, FR, RL, RR) | −1, +1, −1, +1 |
| Techo de vx y vy / wz | 1,0 m/s / 2,0 rad/s |
| Zona muerta | 0,01 m/s y 0,02 rad/s = parar; PWM < 8 no se aplica |
| Control / reporte odométrico | 100 Hz / 50 Hz |
| Timeout | 500 ms |
| Serial | 115200 baudios |

> **Sin protecciones todavía.** El divisor de batería y el comparador de sobrecorriente no están
> soldados, así que `BATTERY_SENSE` y `OVERCURRENT_SENSE` están en `false`: **nada detiene el robot
> con la batería baja o con un motor trabado**. Se activan cuando se monten (ver
> [revisión eléctrica](../docs/hardware/electrica/revision_plano.md)).

## Sketches de prueba

Para la puesta en marcha, uno por carpeta (Arduino exige que la carpeta se llame igual que el
`.ino`). Primero con las ruedas en el aire.

| Sketch | Para qué |
|---|---|
| [motor_test](motor_test/motor_test.ino) | Mover las ruedas sin encoders (lazo abierto), con el mismo protocolo serial |
| [motor_serial_test](motor_serial_test/motor_serial_test.ino) | Mandar un PWM a cada motor por serial |
| [encoder_test](encoder_test/encoder_test.ino) | Leer los encoders y barrer el PWM; `d` cambia entre fast y slow decay |
| [imu_test_uno](imu_test_uno/imu_test_uno.ino) | Probar el MPU6050 con un Arduino UNO |

## Compilar y cargar

Arduino-ESP32 **3.x** (usa `driver/pulse_cnt.h` y la API LEDC nueva); placa ESP32 DOIT DevKit V1.
Desde la raíz del repositorio:

```bash
arduino-cli compile --fqbn esp32:esp32:esp32doit-devkit-v1 firmware
```

```bash
arduino-cli upload --fqbn esp32:esp32:esp32doit-devkit-v1 -p /dev/martha_esp32 firmware
```

Después de cargarlo, seguir la [puesta en marcha](../docs/puesta_en_marcha.md).
