class SensorData {
  double uv = 0;
  double aqi = 0;
  double temperature = 0;
  double humidity = 0;
  double pressure = 0;

  List<double> aqiHistory = [];
  List<double> temperatureHistory = [];
  List<double> pressureHistory = [];

  static const int maxHistorySize = 100; // Ajusta según tus necesidades

  void update(String topic, String value) {
    try {
      double numericValue = double.parse(value);
      switch (topic) {
        case 'sensor/uv':
          uv = numericValue;
          break;
        case 'sensor/aqi':
          aqi = numericValue;
          _updateHistory(aqiHistory, numericValue);
          break;
        case 'sensor/temperature':
          temperature = numericValue;
          _updateHistory(temperatureHistory, numericValue);
          break;
        case 'sensor/humidity':
          humidity = numericValue;
          break;
        case 'sensor/pressure':
          pressure = numericValue;
          _updateHistory(pressureHistory, numericValue);
          break;
      }
      print('Datos actualizados: $topic = $numericValue');
    } catch (e) {
      print('Error al actualizar datos: $e');
    }
  }

  void _updateHistory(List<double> history, double value) {
    history.add(value);
    if (history.length > maxHistorySize) {
      history.removeAt(0);
    }
  }
}