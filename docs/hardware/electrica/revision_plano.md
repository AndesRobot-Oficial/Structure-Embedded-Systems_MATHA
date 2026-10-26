# Revisión documental del sistema eléctrico

Estado al organizar los archivos, 25 de octubre de 2026. No se hicieron mediciones físicas.

- [ ] Confirmar la revisión de PCB fabricada y recuperar esquemático editable, diseño y Gerbers.
- [ ] Documentar la adaptación de nivel de encoders: los PNG muestran alimentación a 5 V y GPIO de 3,3 V, pero no el circuito intermedio. No interpretar las líneas del dibujo como autorización para aplicar 5 V a GPIO.
- [ ] Confirmar batería: química, capacidad, rango descargada/cargada y protecciones. Los 15 V son el valor documentado, no un rango certificado.
- [ ] Revisar divisor de batería 39 kΩ / 10 kΩ y rango ADC contra la tensión máxima real. La tesis indica que no estaba soldado.
- [ ] Confirmar comparador de sobrecorriente y niveles de su salida. La tesis lo describe sin soldar y el firmware no lo consulta (`OVERCURRENT_SENSE = false`).
- [ ] Registrar protección de potencia, parada, conectores, calibres y longitudes reales. Los PNG no bastan para verificar esos elementos.
- [ ] Confirmar tensión de alimentación y módulo concreto de MPU6050.
- [ ] Resolver la diferencia de las dos RealSense: aparecen en el diagrama adicional, pero la tesis excluye RealSense del equipamiento asignado al proyecto.
- [ ] Confirmar correspondencia entre ruedas físicas, signos y pines antes de operar.

Los siete diagramas se conservaron sin modificaciones. La versión completa muestra distribución y las cuatro ramas de motor; la variante RealSense/IMU está en un PNG separado.
