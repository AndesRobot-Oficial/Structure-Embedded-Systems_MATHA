# Pines y conexiones

| Señal ESP32 | Delantera izquierda | Delantera derecha | Trasera izquierda | Trasera derecha |
|---|---:|---:|---:|---:|
| Encoder A | 12 | 36 | 4 | 21 |
| Encoder B | 13 | 39 | 16 | 22 |
| PWM IN1 | 27 | 32 | 15 | 18 |
| PWM IN2 | 14 | 33 | 2 | 19 |

GPIO17 controla nSLEEP de los cuatro drivers. GPIO25/26 son SDA/SCL de la MPU6050. GPIO23 y GPIO34 corresponden a sobrecorriente y medición de batería previstas; su montaje y uso difieren entre tesis y firmware local.

[Tabla de conexiones](tabla_conexiones.csv): conexiones lógicas extraídas de diagramas y firmware, no un conteo de conductores físicos. Calibres y longitudes se dejan vacíos porque no están verificados. Los colores de terminales de motor y encoder se transcriben del diagrama, no de una inspección del arnés.

Las señales de encoder se representan conectadas a GPIO, pero los diagramas no detallan la adaptación entre alimentación de encoder a 5 V y lógica de ESP32 a 3,3 V. Consultar [revisión eléctrica](../revision_plano.md).
