# Pulsera UV Destina

## Enunciado de visión

La pulsera UV Destina es un dispositivo wearable innovador diseñado para deportistas y mujeres que buscan proteger su piel de los dañinos rayos UV. Con sensores integrados y una dashboard complementario. Destinada a proporcionar datos precisos sobre la exposición a los rayos UV, presión atmosférica, calidad del aire y medición de temperatura y humedad en el ambiente, con la finalidad de mitigar los riesgos de cáncer de piel. Su diseño elegante, y batería de larga duración lo convierten en el compañero perfecto para actividades al aire libre. Destina se diferencia de la competencia al ofrecer una solución específica y asequible para aquellos que priorizan la salud de su piel.

## Software empleado

| Nombre                | Licencia                                                                                        |
|-----------------------|--------------------------------------------------------------------------------------------------|
| Node-RED              | Apache License 2.0                                                                              |
| Arduino IDE           | GNU Lesser General Public License (LGPL)                                                        |
| SQLite                | Public Domain                                                                                   |
| Adafruit_Sensor       | Apache License 2.0                                                                              |
| Adafruit_BME280       | BSD License                                                                                     |
| Adafruit_ADXL345      | BSD License                                                                                     |
| Adafruit_CCS811       | Apache License 2.0                                                                              |
| Adafruit_AHTX0        | BSD License                                                                                     |

## Hardware empleado

| Nombre                | Imagen                                    | Descripción                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Cantidad |
|-----------------------|-------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
## Hardware empleado

| ESP32 LVGL            | ![ESP32 LVGL](https://m.media-amazon.com/images/I/61txFmVlQUL._AC_SX522_.jpg)          | La placa de desarrollo ESP32 LVGL cuenta con una pantalla LCD táctil de 2.8 pulgadas y una resolución de 320×240 píxeles. Además, tiene conectividad WiFi y Bluetooth, lo que la hace ideal para proyectos de Robótica, IoT y Domótica.                                                                                                                                                                                                                                                                   | 1        |
| Sensor Ltr390-uv      | ![Sensor Ltr390-uv](https://cdn.shopify.com/s/files/1/0020/8027/6524/products/LTR390UV_720x@2x.jpg?v=1617257430)    | El sensor Ltr390-uv es de bajo consumo con gran estabilidad y sensibilidad, con un ángulo de visión de hasta 130 grados. Es de ultra bajo consumo de aproximadamente 1 mA. Ideal para proyectos de monitoreo de luz UV.                                                                                                                                                                                                                                                                                 | 1        |
| Sensor BMP280         | ![Sensor BMP280](https://cdn-shop.adafruit.com/970x728/2651-00.jpg)       | El módulo BMP280 de presión atmosférica se utiliza para medir la presión barométrica, temperatura y la humedad relativa. Además, todo está integrado en un solo chip piezo-resistivo realmente compacto y de bajo consumo energético.                                                                                                                                                                                                                                                                    | 1        |
| Sensor CCS811, EN160+ATH21 | ![Sensor CCS811, EN160+ATH21](https://cdn.shopify.com/s/files/1/0020/8027/6524/products/ENS160_720x@2x.jpg?v=1636973723) | Es un sensor multigas digital especialmente diseñado para el monitoreo de la calidad del aire interior. Puede detectar mejor una variedad de gases y compuestos orgánicos volátiles (COV), incluyendo tolueno, hidrógeno, etanol, NO2 y ozono.                                                                                                                                                                                                                                                             | 1        |
| Zumbador buzzer KY-006 | ![Zumbador buzzer KY-006](https://www.electronicoscaldas.com/3183-large_default/modulo-buzzer-pasivo-ky-006.jpg) | El Zumbador Buzzer Pasivo Módulo KY-006 es un sensor piezoeléctrico el cual puede reproducir tonos de sonido entre un rango de 1.5Hz a 2.5 kHz dependiendo de la frecuencia de entrada, ya sea mediante retardos o modulación de ancho de pulso.                                                                                                                                                                                                                                                         | 1        |
| ESP32                 | ![ESP32](https://m.media-amazon.com/images/I/61CGj47IJNS._AC_SX522_.jpg)               | El ESP32 emplea un microprocesador Tensilica Xtensa LX6 en sus variantes de simple y doble núcleo e incluye interruptores de antena, balun de radiofrecuencia, amplificador de potencia, amplificador receptor de bajo ruido, filtros, y módulos de administración de energía.                                                                                                                                                                                                                           | 1        |
| Leds                  | ![Leds](https://uelectronics.com/wp-content/uploads/2017/06/M02007-1.jpg)                | Dispositivo que permite el paso de corriente en un solo sentido y que al ser polarizado emite un haz de luz.                                                                                                                                                                                                                                                                                                                                                                                             | 2        |

## Historias de usuario épicas

1. **Medición de temperatura y humedad ambiental**
   - Como usuario, quiero que la pulsera mida y muestre la temperatura y humedad ambiental para estar al tanto de las condiciones ambientales y tomar decisiones informadas.

2. **Monitoreo de la calidad del aire**
   - Como usuario, quiero que la pulsera detecte y alerte sobre niveles peligrosos de gases y compuestos orgánicos volátiles en el aire para proteger mi salud respiratoria.

3. **Detección de rayos UV y alertas de protección solar**
   - Como usuario, quiero que la pulsera mida los niveles de radiación UV y me avise cuando sea necesario aplicar protector solar o buscar sombra para prevenir daños en la piel.

## Prototipo propuesto

![Prototipo de la pulsera UV Destina](ruta/a/la/imagen.jpg)

## Arquitectura del proyecto

![Arquitectura del proyecto](ruta/a/la/imagen.jpg)

La arquitectura del proyecto incluye los siguientes elementos:
- Sensores: Ltr390-uv (rayos UV), BMP280 (temperatura, humedad y presión atmosférica), CCS811 y EN160+ATH21 (calidad del aire)
- Controlador: ESP32 LVGL con pantalla LCD táctil
- Plataforma de base de datos: SQLite para almacenamiento local de datos
- Protocolo de comunicación: HTTP y MQTT para envío de datos a Node-RED y comunicación con dispositivos receptores
- Gestión de energía: Batería recargable y optimización del consumo energético
- Dispositivos receptores: Panel de control en Node-RED para monitoreo y visualización de datos

## Tablero Kanban

![Tablero Kanban Sprint 1](ruta/a/la/imagen.jpg)
![Tablero Kanban Sprint 2](ruta/a/la/imagen.jpg)
![Tablero Kanban Sprint 3](ruta/a/la/imagen.jpg)

## Circuito diseñado

![Circuito del proyecto](ruta/a/la/imagen.jpg)

## Resultados

![Resultado 1](ruta/a/la/imagen.jpg)
Descripción del resultado 1.

![Resultado 2](ruta/a/la/imagen.jpg)
Descripción del resultado 2.

![Resultado 3](ruta/a/la/imagen.jpg)
Descripción del resultado 3.
