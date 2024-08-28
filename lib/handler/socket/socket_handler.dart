import 'dart:convert';
import 'package:campuslink/app/url.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketChannel? _channel;

  void connect() {
    _channel = WebSocketChannel.connect(
      Uri.parse(Url.chatWebSocket),
    );
  }

  Stream<dynamic> getStream() {
    if (_channel == null) {
      throw Exception('WebSocket channel is not connected');
    }
    return _channel!.stream.map((event) => jsonDecode(event));
  }

  void sendMessage(Map<String, dynamic> message) {
    if (_channel == null) {
      throw Exception('WebSocket channel is not connected');
    }
    _channel!.sink.add(jsonEncode(message));
  }

  void disconnect() {
    if (_channel != null) {
      _channel!.sink.close();
    }
  }
}
