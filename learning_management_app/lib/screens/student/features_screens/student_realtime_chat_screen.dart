import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../models/student/teacher_chat_response.dart';
import '../../../core/network/stomp_chat_service.dart';
import '../../../core/storage/secure_storage.dart';

class ChatMessage {
  final String senderEmail;
  final String content;
  final String timestamp;
  final bool isMine;

  ChatMessage({
    required this.senderEmail,
    required this.content,
    required this.timestamp,
    required this.isMine,
  });
}

class StudentRealtimeChatScreen extends StatefulWidget {
  final TeacherChatResponse teacher;

  const StudentRealtimeChatScreen({super.key, required this.teacher});

  @override
  State<StudentRealtimeChatScreen> createState() => _StudentRealtimeChatScreenState();
}

class _StudentRealtimeChatScreenState extends State<StudentRealtimeChatScreen> {
  final StompChatService _chatService = StompChatService();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isConnected = false;

  bool _isLoadingHistory = true;

  @override
  void initState() {
    super.initState();
    _loadHistoryAndConnect();
  }

  Future<void> _loadHistoryAndConnect() async {
    // 1. Fetch History
    try {
      final token = await SecureStorage.getToken();
      final url = Uri.parse('http://localhost:8080/api/chat/history?userEmail=${widget.teacher.email}');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          _messages.addAll(data.map((msg) {
            return ChatMessage(
              senderEmail: msg['senderEmail'] ?? '',
              content: msg['content'] ?? '',
              timestamp: msg['timestamp'] ?? '',
              isMine: msg['senderEmail'] != widget.teacher.email,
            );
          }));
          _isLoadingHistory = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      debugPrint('Error loading history: $e');
      setState(() => _isLoadingHistory = false);
    }

    // 2. Connect STOMP
    _chatService.onConnected = () {
      if (mounted) {
        setState(() {
          _isConnected = true;
        });
      }
    };

    _chatService.onMessageReceived = (message) {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            senderEmail: message['senderEmail'] ?? '',
            content: message['content'] ?? '',
            timestamp: message['timestamp'] ?? '',
            isMine: message['senderEmail'] != widget.teacher.email,
          ));
        });
        _scrollToBottom();
      }
    };

    _chatService.connect(widget.teacher.email);
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _chatService.sendMessage(widget.teacher.email, text);
    _controller.clear();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _chatService.disconnect();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1E293B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF4F46E5).withOpacity(0.1),
                  child: Text(
                    widget.teacher.teacherName.isNotEmpty ? widget.teacher.teacherName[0].toUpperCase() : 'GV',
                    style: GoogleFonts.inter(color: const Color(0xFF4F46E5), fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _isConnected ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.teacher.teacherName,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF1E293B),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    _isConnected ? 'Đang hoạt động' : 'Đang kết nối...',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF64748B),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _isLoadingHistory
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _messages.isEmpty
                      ? Center(
                          child: Text(
                            'Không có tin nhắn',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF94A3B8),
                              fontSize: 14,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final msg = _messages[index];
                            return _buildMessageBubble(msg);
                          },
                        ),
                ),
                _buildInputArea(),
              ],
            ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    return Align(
      alignment: msg.isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: msg.isMine ? const Color(0xFF4F46E5) : Colors.white,
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: msg.isMine ? const Radius.circular(0) : const Radius.circular(16),
            bottomLeft: !msg.isMine ? const Radius.circular(0) : const Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          msg.content,
          style: GoogleFonts.inter(
            color: msg.isMine ? Colors.white : const Color(0xFF1E293B),
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ).animate().fade(duration: 200.ms).slideY(begin: 0.2, end: 0),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Nhắn tin...',
                    hintStyle: GoogleFonts.inter(color: const Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFF4F46E5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
