# Estado del desarrollo para RoboCup

## Material disponible

- Siete diagramas eléctricos de potencia, motores y sensores.
- Proyecto KiCad, esquemático, PCB, librerías y ZIP de Gerbers.
- Firmware ESP32 e interfaces ROS como base de integración.
- Inventario de componentes, conexiones, cuatro fotos y un video de MARTHA.

## Próximas tareas

- [ ] Definir con el equipo la categoría, edición y requisitos de RoboCup que guiarán la integración.
- [ ] Revisar el diseño de PCB, completar resistencias sin valor y ejecutar ERC/DRC.
- [ ] Generar Gerbers desde la revisión aprobada; comprobar el ZIP aportado antes de reutilizarlo.
- [ ] Conciliar la etiqueta de potencia `+12V` de KiCad con la batería indicada como 15 V en los diagramas.
- [ ] Verificar GPIO23, adaptación de niveles de encoders y rango de medición de batería.
- [ ] Registrar qué circuitos están montados y qué protecciones se han comprobado.
- [ ] Confirmar firmware cargado, signos de ruedas, límites, ganancias PI y calibración de sensores.
- [ ] Completar capacidad de batería, consumos, autonomía, conectores y calibres.
- [ ] Confirmar modelos y montaje de las dos RealSense representadas en el diagrama.
- [ ] Incorporar el diseño mecánico editable cuando esté disponible.

La documentación describe el estado disponible del proyecto. La preparación para la competencia requiere comprobar la plataforma y los requisitos de la categoría elegida.
