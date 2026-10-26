# Revisión de integración eléctrica

Pendientes concretos del diseño y del montaje de MARTHA para RoboCup.

- [ ] Comprobar que PCB, esquemático y Gerbers representan la misma revisión. El ZIP aportado contiene archivos fechados el 31 de julio de 2026.
- [ ] Resolver la diferencia entre la red `+12V` de KiCad y la batería de 15 V indicada en los diagramas.
- [ ] Verificar tensión máxima, capacidad, química y protecciones de la batería.
- [ ] Verificar adaptación entre señales de encoder y GPIO del ESP32; los diagramas no detallan todos los circuitos intermedios.
- [ ] Revisar R4: el PCB la conecta desde `+5V4` a GPIO23. Comprobar compatibilidad de niveles.
- [ ] Verificar rango del divisor de batería R5/R6 (39 kΩ / 10 kΩ) frente a la tensión máxima de batería y al ADC.
- [ ] Soldar el divisor de batería y el comparador de sobrecorriente (hoy no están en la placa), calibrar RV1/LM339 y activar `BATTERY_SENSE` y `OVERCURRENT_SENSE` en el [firmware](../../../firmware/README.md).
- [ ] Completar R2, R3 y R7–R10, que figuran con valor genérico `R` en el PCB.
- [ ] Registrar fusibles, parada, calibres y longitudes reales de cableado.
- [ ] Confirmar alimentación y montaje de IMU y cámaras.

[Descripción de la PCB](../pcb/README.md) · [Diagramas originales](esquematicos/README.md)
