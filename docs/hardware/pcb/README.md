[← Inicio](../../../README.md) · [Diagramas eléctricos](../electrica/README.md)

# PCB de control de MARTHA

**Una placa de interconexión para concentrar el control y la potencia de las cuatro ruedas mecanum.** Aloja el ESP32 y los cuatro módulos de driver, conecta motores y encoders, y reúne las señales de la IMU, batería y supervisión de corriente.

## Archivos del diseño

| Archivo | Contenido |
|---|---|
| [Proyecto KiCad](diseno/martha_circuits/martha_circuits.kicad_pro) | Configuración del proyecto |
| [Esquemático](diseno/martha_circuits/martha_circuits.kicad_sch) | Circuito editable |
| [PCB](diseno/martha_circuits/martha_circuits.kicad_pcb) | Distribución de componentes y ruteo |
| [Gerbers aportados](diseno/martha_circuits/Gerbers.zip) | Capas de fabricación y archivos de taladrado |
| [Componentes de la PCB](componentes_pcb.csv) | Referencias, valores y huellas extraídos del diseño |

El archivo PCB fue guardado con **KiCad 10.0**. Tiene dos capas de cobre, un contorno rectangular de **115 × 129 mm**, espesor configurado de **1,6 mm** y cuatro huellas de fijación M4 con perforación nominal de 4,3 mm. Son propiedades del diseño, no mediciones de una placa fabricada.

## Bloques funcionales

| Bloque | Referencias | Función en el diseño |
|---|---|---|
| Microcontrolador | U0 | Zócalo para ESP32 DevKit de 30 pines: PWM, encoders, I2C y supervisión |
| Control de motores | U1–U4 | Cuatro huellas de módulos MPQ6612A; una por rueda |
| Motores y encoders | J1–J4 | Cuatro conectores de seis contactos para potencia de motor, alimentación y señales de encoder |
| Entrada de batería | J5, SW1, Q1 | Conector DEANS, conexión de interruptor y MOSFET IRF4905 en el recorrido de potencia |
| Medición de batería | R5, R6, C2 | Divisor 39 kΩ / 10 kΩ hacia la red `Batt_Charge`, asociada a GPIO34; filtrado capacitivo |
| Supervisión de corriente | U5, RV1 | LM339 compara las cuatro señales ViSEN con la referencia VD; salidas reunidas hacia GPIO23 |
| Conector IMU | J6 | Huella de ocho pines: 3,3 V, GND, SCL y SDA conectados; los otros cuatro sin red asignada |
| Indicadores | D1–D4 | Cuatro LED y resistencias asociadas |

La relación del divisor de batería es 4,9: la entrada ADC recibe aproximadamente la tensión de batería dividida por 4,9. El nombre de la red de potencia en KiCad es `+12V`; los diagramas de la plataforma indican una batería de 15 V. Esta diferencia debe resolverse en la documentación de la revisión a fabricar.

## Librerías incluidas

- [ESP32](diseno/martha_circuits/ESP32_dev_module.pretty/ESP32_DevKit_30Pin.kicad_mod): huella de la placa de 30 pines.
- [Driver MPQ6612A](diseno/Pololu_Driver.pretty/MPQ6612A.kicad_mod).
- [Conector DEANS](diseno/My_Components.pretty/My_Components.pretty/DEANS.kicad_mod).
- [Conector de motor/encoder](diseno/My_Components.pretty/My_Components.pretty/PinHeader_1x06_P2.54mm_Horizontal_Mirrored.kicad_mod).
- Símbolos personalizados de ESP32 y driver en la carpeta del proyecto.

Se conservó la estructura relativa de librerías y `fp-lib-table`. Para abrirlo, descargar el repositorio completo y abrir el archivo `.kicad_pro`. Si KiCad solicita registrar símbolos, usar los `.kicad_sym` incluidos en esa misma carpeta.

## Revisión antes de fabricar o energizar

- **Gerbers:** el ZIP contiene archivos fechados el 31 de julio de 2026. Se conserva el original; aún no se comprobó que corresponda al PCB editable aportado. Regenerar desde la revisión aprobada antes de encargar fabricación.
- **GPIO23:** R4 aparece como 100 kΩ entre `+5V4` y la señal hacia GPIO23. Revisar la compatibilidad de nivel con la entrada del ESP32.
- **Valores por completar:** R2, R3 y R7–R10 conservan el valor genérico `R`; especificarlos en la BOM de fabricación.
- **Montaje:** verificar adaptación de niveles de encoders, tensión máxima de batería y calibración de la referencia de corriente.

La descripción se obtuvo leyendo las huellas, redes y contorno del archivo KiCad. No se ejecutaron ERC/DRC ni se verificó físicamente la placa en esta revisión documental.
