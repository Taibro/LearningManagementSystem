import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import '../storage/secure_storage.dart';

class StompChatService {
  late StompClient _stompClient;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Callback when a message is received
  Function(Map<String, dynamic>)? onMessageReceived;
  Function()? onConnected;
  
  Future<void> connect(String receiverEmail) async {
    final token = await SecureStorage.getToken();
    
    _stompClient = StompClient(
      config: StompConfig(
        url: 'ws://localhost:8080/ws', // For real device with adb reverse or local testing
        onConnect: (StompFrame frame) {
          if (onConnected != null) onConnected!();
          
          // Subscribe to user's private queue
          _stompClient.subscribe(
            destination: '/user/queue/messages',
            callback: (StompFrame frame) {
              if (frame.body != null) {
                final message = json.decode(frame.body!);
                if (onMessageReceived != null) {
                  onMessageReceived!(message);
                }
              }
            },
          );
        },
        stompConnectHeaders: {
          'Authorization': 'Bearer $token',
        },
        webSocketConnectHeaders: {
          'Authorization': 'Bearer $token',
        },
        onWebSocketError: (dynamic error) => debugPrint('WebSocket Error: $error'),
        onStompError: (StompFrame frame) => debugPrint('Stomp Error: ${frame.body}'),
        onDisconnect: (StompFrame frame) => debugPrint('Disconnected'),
      ),
    );
    
    _stompClient.activate();
  }

  void sendMessage(String receiverEmail, String content) {
    if (_stompClient.isActive) {
      _stompClient.send(
        destination: '/app/chat.send',
        body: json.encode({
          'receiverEmail': receiverEmail,
          'content': content,
        }),
      );
    }
  }

  void disconnect() {
    _stompClient.deactivate();
  }
}
