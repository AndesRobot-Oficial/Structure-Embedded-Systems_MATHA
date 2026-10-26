[← Inicio](../../../README.md)

# Eléctrica

**De la batería a cada rueda:** distribución de potencia, control y conexiones de la base MARTHA.

[![Distribución general de potencia de MARTHA](esquematicos/01_distribucion_potencia.png)](esquematicos/README.md)

| Consultar el diseño | Preparar el montaje |
|---|---|
| **[Atlas de diagramas](esquematicos/README.md)**<br>Vista general, cuatro motores y sensores. | **[Pines y conexiones](cableado/README.md)**<br>Asignación GPIO y señales compartidas. |
| **[Tabla de conexiones CSV](cableado/tabla_conexiones.csv)**<br>Origen, destino y observaciones. | **[Revisión eléctrica](revision_plano.md)**<br>Diferencias y datos que falta verificar. |
| **[Materiales](../bom/README.md)**<br>Componentes y cantidades. | **[Presupuesto de potencia](presupuesto_potencia.csv)**<br>Plantilla con consumos pendientes de medición. |

## Dominios de alimentación

| Dominio | Alimenta | Dato documentado |
|---|---|---|
| Batería | Cuatro drivers de motor | 15 V; rango real y capacidad pendientes |
| Salidas de drivers | Motores y encoders asociados | Motores nominales de 12 V; encoders a 5 V en el diagrama |
| USB del PC | ESP32 y LiDAR | Alimentación y datos |

Los PNG son diagramas de conexión aportados por el equipo. Los originales editables de la PCB, calibres, protecciones y adaptaciones de nivel se describen en [revisión eléctrica](revision_plano.md).
