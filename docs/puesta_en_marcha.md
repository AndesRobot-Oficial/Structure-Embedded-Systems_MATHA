# Puesta en marcha de MARTHA

Secuencia de integración de la base móvil para el proyecto RoboCup.

1. Identificar PCB y firmware utilizados; registrar revisión y componentes montados.
2. Revisar alimentación, polaridad, niveles de señal y los puntos de la [revisión eléctrica](../electrica/revision_plano.md).
3. Compilar el firmware con el soporte ESP32 correspondiente y registrar la versión del entorno.
4. Con las ruedas levantadas, verificar correspondencia de cada rueda, motor, encoder y signo de giro.
5. Comprobar seguimiento de velocidad, ajustar PI y documentar radio efectivo y cuentas por vuelta.
6. Verificar IMU, comunicación serial, odometría y LiDAR en ROS 2.
7. Comprobar timeout y las protecciones realmente implementadas en la placa.
8. Registrar condiciones y resultados antes de ampliar las pruebas de la competencia.

[Fotos y video de la plataforma](evidencias/README.md) · [Estado del desarrollo](estado_y_pendientes.md)
