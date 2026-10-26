# Estado y diferencias entre fuentes

Organización: 25 de octubre de 2026. Se cotejó el firmware local con el anexo de hardware de la tesis activa y con los PNG aportados. No se modificó el código para adivinar la revisión utilizada.

| Tema | Copia local incluida | Tesis activa |
|---|---|---|
| Revisión identificada | e7993a9 (checkout local) | Anexo cita c8faa84 |
| Kp | 2,0 | 1,0 |
| Signos motores | +1,+1,+1,+1 | +1,-1,+1,-1 |
| Signos encoders | +1,+1,+1,+1 | -1,+1,-1,+1 |
| Límite lineal / angular | 0,5 m/s / 1,2 rad/s | 1,0 m/s / 2,0 rad/s |
| Batería y sobrecorriente | Comprobaciones habilitadas | Circuitos sin soldar y comprobaciones omitidas al 21/10/2026 |

Además, el diagrama `07_realsense_imu.png` representa dos RealSense, mientras el presupuesto de tesis indica que RealSense no estaba asignada al proyecto. Se conservó la variante sin incorporarla como equipamiento experimental confirmado.

## Pendientes

- [ ] Recuperar y contrastar el firmware efectivamente cargado en las pruebas; identificar commit o fecha.
- [ ] Resolver signos, ganancias, límites y estado de protecciones con esa revisión.
- [ ] Confirmar montaje de cámaras y alimentación del módulo IMU.
- [ ] Recuperar CAD y PCB/Gerbers originales.
- [ ] Completar consumos, batería, conectores y cableado mediante datos o mediciones.
- [ ] Confirmar licencia de distribución del código y diseños antes de asignar una licencia al conjunto.

Se incluyeron diagramas, BOM, conexiones, firmware de referencia, interfaces ROS, fuentes gráficas y evidencias. No se copiaron URDF, modelos de entrenamiento, temporales, currículos ni versiones anteriores de la tesis.
