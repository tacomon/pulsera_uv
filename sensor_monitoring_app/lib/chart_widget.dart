import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'mqtt_service.dart';
import 'sensor_data.dart';
import 'dart:math' as math;

class ChartWidget extends StatefulWidget {
  final MqttService mqttService;

  ChartWidget({required this.mqttService});

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  SensorData sensorData = SensorData();

  @override
  void initState() {
    super.initState();
    widget.mqttService.onDataReceived = (topic, value) {
      setState(() {
        sensorData.update(topic, value);
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Registro de datos'),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildGaugeCard('Temperatura',
                        sensorData.temperature, 50, '°C', Colors.red)),
                SizedBox(width: 16),
                Expanded(
                    child: _buildGaugeCard('Humedad', sensorData.humidity, 100,
                        '%', Colors.blue)),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildGaugeCard(
                        'Rayos UV', sensorData.uv, 11, '', Colors.purple)),
                SizedBox(width: 16),
                Expanded(
                    child: _buildGaugeCard(
                        'CO2', sensorData.aqi, 500, '', Colors.orange)),
              ],
            ),
            SizedBox(height: 16),
            _buildGaugeCard(
                'Presión', sensorData.pressure, 1100, 'hPa', Colors.green),
            SizedBox(height: 32),
            _buildSectionTitle('Historical Data'),
            SizedBox(height: 16),
            _buildHistoryChart(
                'Temperatura Historial',
                sensorData.temperatureHistory,
                _isFavorable(sensorData.temperature, 20, 30)
                    ? Colors.green
                    : Colors.red),
            SizedBox(height: 16),
            _buildHistoryChart(
                'CO2 Historial',
                sensorData.aqiHistory,
                _isFavorable(sensorData.aqi, 0, 300)
                    ? Colors.green
                    : Colors.red),
            SizedBox(height: 16),
            _buildHistoryChart(
                'Presion Historial',
                sensorData.pressureHistory,
                _isFavorable(sensorData.pressure, 950, 1050)
                    ? Colors.green
                    : Colors.red),
            SizedBox(height: 32),
            _buildSectionTitle('Data Summary'),
            SizedBox(height: 16),
            _buildDataTable(),
          ],
        ),
      ),
    );
  }

  // Verifica si los datos son favorables dentro de un rango
  bool _isFavorable(double value, double minValue, double maxValue) {
    return value >= minValue && value <= maxValue;
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildGaugeCard(
      String title, double value, double maxValue, String unit, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: CustomPaint(
                size: Size(120, 120),
                painter: GaugePainter(
                    value: value, maxValue: maxValue, color: color),
              ),
            ),
            SizedBox(height: 8),
            Text(
              title == 'Rayos UV'
                  ? _formatUV(value)
                  : '${value.toStringAsFixed(1)}$unit',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }

String _formatUV(double uv) {
  double porcentaje;
  String descripcion;

  if (uv < 3) {
    porcentaje = (uv / 3) * 100;
    descripcion = "Bajo";
  } else if (uv >= 3 && uv < 6) {
    porcentaje = ((uv - 3) / (6 - 3)) * 100;
    descripcion = "Moderado";
  } else if (uv >= 6 && uv < 8) {
    porcentaje = ((uv - 6) / (8 - 6)) * 100;
    descripcion = "Alto";
  } else if (uv >= 8 && uv < 11) {
    porcentaje = ((uv - 8) / (11 - 8)) * 100;
    descripcion = "Muy alto";
  } else {
    porcentaje = 100; // Asegurarse de que no exceda 100%
    descripcion = "Extremo";
  }

  return '${porcentaje.toStringAsFixed(1)}% - $descripcion';
}


  Widget _buildHistoryChart(String title, List<double> data, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: false),
                  titlesData: const FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: data.length.toDouble() - 1,
                  minY: data.isEmpty ? 0 : data.reduce(math.min),
                  maxY: data.isEmpty ? 1 : data.reduce(math.max),
                  lineBarsData: [
                    LineChartBarData(
                      spots: data
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value))
                          .toList(),
                      isCurved: true,
                      color: color,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                          show: true, color: color.withOpacity(0.2)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          border: TableBorder.all(color: Colors.grey[300]!),
          children: [
            _buildTableRow('Sensor', 'Value', isHeader: true),
            _buildTableRow('UV Index', '${sensorData.uv.toStringAsFixed(2)}'),
            _buildTableRow('AQI', '${sensorData.aqi.toStringAsFixed(2)}'),
            _buildTableRow('Temperature',
                '${sensorData.temperature.toStringAsFixed(2)}°C'),
            _buildTableRow(
                'Humidity', '${sensorData.humidity.toStringAsFixed(2)}%'),
            _buildTableRow(
                'Pressure', '${sensorData.pressure.toStringAsFixed(2)} hPa'),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value, {bool isHeader = false}) {
    TextStyle style =
        isHeader ? TextStyle(fontWeight: FontWeight.bold) : TextStyle();
    return TableRow(
      decoration: BoxDecoration(
        color: isHeader ? Colors.grey[200] : null,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label, style: style),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value, style: style, textAlign: TextAlign.right),
        ),
      ],
    );
  }
}

class GaugePainter extends CustomPainter {
  final double value;
  final double maxValue;
  final Color color;

  GaugePainter(
      {required this.value, required this.maxValue, required this.color});

@override
void paint(Canvas canvas, Size size) {
  final center = Offset(size.width / 2, size.height / 2);
  final radius = math.min(size.width, size.height) / 2;

  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10;

  // Draw background arc
  paint.color = Colors.grey[300]!;
  canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 0,
      2 * math.pi, false, paint);

  double limitedValue = value > maxValue ? maxValue : value;

  // Draw value arc
  paint.color = color;
  double sweepAngle = (limitedValue / maxValue) * 2 * math.pi;
  canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -math.pi / 2,
      sweepAngle, false, paint);
}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
