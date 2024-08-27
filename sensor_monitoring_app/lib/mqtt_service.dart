import 'dart:typed_data';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final String broker = '192.168.42.164';
  final String clientIdentifier = 'utng/proyect/sensores';
  final int port = 1883;

  MqttServerClient? client;
  Function(String, String)? onDataReceived;

  void connect() async {
    client = MqttServerClient(broker, clientIdentifier);
    client!.port = port;
    client!.logging(on: true);
    client!.keepAlivePeriod = 20;

    client!.onConnected = onConnected;
    client!.onDisconnected = onDisconnected;

    try {
      print('Intentando conectar al broker MQTT...');
      await client!.connect();
      print('Conectado exitosamente al broker MQTT');
    } catch (e) {
      print('Error al conectar al broker MQTT: $e');
      disconnect();
    }
  }

  void disconnect() {
    client?.disconnect();
  }

void onConnected() {
  print('Connected to MQTT broker');
  client!.subscribe('sensor/uv', MqttQos.atLeastOnce);
  client!.subscribe('sensor/aqi', MqttQos.atLeastOnce);
  client!.subscribe('sensor/temperature', MqttQos.atLeastOnce);
  client!.subscribe('sensor/humidity', MqttQos.atLeastOnce);
  client!.subscribe('sensor/pressure', MqttQos.atLeastOnce);

  client!.updates?.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
    for (var message in messages) {
      final MqttPublishMessage recMess = message.payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      final topic = message.topic;
      print('Mensaje recibido en MQTT: tema <$topic>, payload <$payload>');
      onDataReceived?.call(topic, payload);
    }
  });
}

  void onDisconnected() {
    print('Disconnected from MQTT broker');
  }
}