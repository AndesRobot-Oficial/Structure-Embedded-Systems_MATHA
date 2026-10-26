# Estado y diferencias entre fuentes

Organización: 25 de octubre de 2026. Se cotejó el firmware con el anexo de hardware de la tesis activa y con los PNG aportados.

**Firmware resuelto (25/10/2026):** la carpeta [firmware](../firmware/README.md) ahora tiene la revisión que funciona en el robot (`c8faa84` de `martha_nav`, la que cita el anexo de la tesis). La copia anterior (`e7993a9`) era más vieja:

| Tema | Copia anterior (e7993a9) | Firmware actual (c8faa84) |
|---|---|---|
| Kp | 2,0 | 1,0, sobre un feedforward |
| Signos motores | +1,+1,+1,+1 | +1,-1,+1,-1 |
| Signos encoders | +1,+1,+1,+1 | -1,+1,-1,+1 |
| Límite lineal / angular | 0,5 m/s / 1,2 rad/s | 1,0 m/s / 2,0 rad/s |
| Batería y sobrecorriente | Comprobaciones habilitadas | Circuitos sin soldar y comprobaciones apagadas (`false`) desde el 21/10/2026 |

Además, el diagrama `07_realsense_imu.png` representa dos RealSense, mientras el presupuesto de tesis indica que RealSense no estaba asignada al proyecto. Se conservó la variante sin incorporarla como equipamiento experimental confirmado.

## Pendientes

- [x] Recuperar el firmware cargado en las pruebas: `c8faa84` (signos, ganancias y límites resueltos).
- [ ] Soldar el divisor de batería y el comparador de sobrecorriente, y activar sus comprobaciones.
- [ ] Confirmar montaje de cámaras y alimentación del módulo IMU.
- [ ] Recuperar CAD y PCB/Gerbers originales.
- [ ] Completar consumos, batería, conectores y cableado mediante datos o mediciones.
- [ ] Confirmar licencia de distribución del código y diseños antes de asignar una licencia al conjunto.

Se incluyeron diagramas, BOM, conexiones, firmware, interfaces ROS, fuentes gráficas y evidencias. El URDF se agregó después en `ros2_ws/src/andesrobot_description`. No se copiaron modelos de entrenamiento, temporales, currículos ni versiones anteriores de la tesis.
