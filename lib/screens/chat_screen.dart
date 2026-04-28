import 'package:flutter/material.dart';
import '../models/chat_model.dart';  // Perbaiki path
import '../widgets/chat_bubble.dart';  // Perbaiki path

class ChatScreen extends StatefulWidget {
  final ChatModel chat;

  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<MessageModel> _messages = [];
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    // Seed dummy messages
    _messages.addAll([
      MessageModel(
        id: '1',
        text: 'Hei, apa kabar?',
        isMine: false,
        timestamp: '10:00',
        status: 'read',
      ),
      MessageModel(
        id: '2',
        text: 'Baik nih, lagi ngerjain WhatsTing 😄',
        isMine: true,
        timestamp: '10:02',
        status: 'read',
      ),
      MessageModel(
        id: '3',
        text: 'Wah keren! Fitur apa yang lagi dikerjain?',
        isMine: false,
        timestamp: '10:03',
        status: 'read',
      ),
      MessageModel(
        id: '4',
        text: 'Chat screen + bubble! Hampir selesai nih',
        isMine: true,
        timestamp: '10:05',
        status: 'delivered',
      ),
    ]);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_ctrl.text.trim().isEmpty) return;
    setState(() {
      _messages.add(MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: _ctrl.text.trim(),
        isMine: true,
        timestamp: _timeNow(),
        status: 'sent',
      ));
      _ctrl.clear();
    });
    // Auto-scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
    // Simulate reply
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _messages.add(MessageModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            text: _getAutoReply(),
            isMine: false,
            timestamp: _timeNow(),
            status: 'read',
          ));
        });
      }
    });
  }

  String _timeNow() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  String _getAutoReply() {
    const replies = [
      'Oke siap! 👍',
      'Mantap nih! 🔥',
      'Flutter emang keren ya 😄',
      'Semangat ngodingnya!',
      'Nanti share hasilnya ya',
      'Gas terus! 🚀',
    ];
    return replies[DateTime.now().second % replies.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE5DD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        foregroundColor: Colors.white,
        leadingWidth: 30,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.chat.avatarUrl),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chat.contactName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Text('online', style: TextStyle(fontSize: 12, color: Color(0xFFB2ECA0))),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (_, i) => ChatBubble(message: _messages[i]),
            ),
          ),
          Container(
            color: const Color(0xFFF0F0F0),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _ctrl,
                      decoration: const InputDecoration(
                        hintText: 'Ketik pesan...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF25D366),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white, size: 22),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}