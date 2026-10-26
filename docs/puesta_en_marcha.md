# Puesta en marcha: guía de comprobación

Esta guía organiza verificaciones pendientes; no registra pruebas realizadas durante esta entrega.

1. Identificar revisión de PCB y firmware cargado. Resolver las [diferencias documentales](estado_y_pendientes.md).
2. Confirmar alimentación, continuidad, polaridad y adaptación de niveles de señales según la [revisión eléctrica](hardware/electrica/revision_plano.md).
3. Compilar el firmware compatible con la placa. Verificar puerto serial por identificador del dispositivo, porque ESP32 y LiDAR pueden intercambiar números ttyUSB.
4. Con ruedas levantadas y alimentación controlada, verificar correspondencia rueda–motor–encoder y signos; comprobar avance, lateral y giro de forma individual.
5. Comparar velocidades ordenadas y medidas; registrar ajuste de PI, radio efectivo y cuentas por vuelta.
6. Verificar giro Z de IMU y sesgo en reposo. Confirmar recepción de odometría y sensores en ROS.
7. Comprobar timeout de comunicaciones y las protecciones que estén realmente implementadas. No asumir que existen por estar escritas en una versión de código.
8. Registrar revisión, condiciones, observaciones y resultado de cada prueba antes de ensayar navegación.

Las pruebas físicas documentadas se consultan en [evidencias](evidencias/README.md). Los videos no certifican por sí solos las protecciones eléctricas.
