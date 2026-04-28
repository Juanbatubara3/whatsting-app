import 'package:flutter/material.dart';
import '../models/models.dart';

class WitScreen extends StatefulWidget {
  const WitScreen({super.key});

  @override
  State<WitScreen> createState() => _WitScreenState();
}

class _WitScreenState extends State<WitScreen> {
  final List<WitMessage> _messages = [];
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messages.add(const WitMessage(
      text: 'Hei! Aku Wit 🤖, asisten AI kamu di WhatsTing.\nAku bisa bantu kamu menjawab pertanyaan, memberikan rekomendasi produk, atau membantu menyusun pesan. Ada yang bisa aku bantu? 😊',
      isFromWit: true,
      timestamp: '',
    ));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(WitMessage(text: text, isFromWit: false, timestamp: _timeNow()));
      _ctrl.clear();
      _isTyping = true;
    });
    _scrollToBottom();

    // Simulate AI response
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      setState(() {
        _isTyping = false;
        _messages.add(WitMessage(text: _generateReply(text), isFromWit: true, timestamp: _timeNow()));
      });
      _scrollToBottom();
    }
  }

  String _generateReply(String input) {
    final lower = input.toLowerCase();
    if (lower.contains('halo') || lower.contains('hai') || lower.contains('hello')) {
      return 'Halo juga! 👋 Senang bertemu denganmu. Ada yang ingin kamu tanyakan?';
    } else if (lower.contains('produk') || lower.contains('beli') || lower.contains('rekomendasi')) {
      return 'Berikut rekomendasi produk terpopuler minggu ini:\n\n🎧 Headphone Bluetooth Pro - Rp 450.000 (⭐4.8)\n👟 Sepatu Sneakers Casual - Rp 320.000 (⭐4.7)\n⌚ Smartwatch Series 5 - Rp 890.000 (⭐4.9)\n\nMau lihat lebih banyak? Kunjungi tab Toko!';
    } else if (lower.contains('flutter') || lower.contains('coding') || lower.contains('code')) {
      return 'Flutter itu framework UI dari Google yang keren banget! 🚀\n\nDengan Flutter, kamu bisa bikin app mobile, web, dan desktop dari satu codebase menggunakan bahasa Dart.\n\nAda yang ingin kamu pelajari tentang Flutter?';
    } else if (lower.contains('apa kabar') || lower.contains('gimana')) {
      return 'Aku baik-baik aja nih! Siap membantu kamu 24/7 tanpa capek 😄\nKamu sendiri gimana?';
    } else if (lower.contains('pesan') || lower.contains('tulis')) {
      return 'Tentu! Aku bisa bantu kamu menyusun pesan. Ceritakan sedikit konteksnya — pesan untuk siapa dan apa tujuannya? 📝';
    } else if (lower.contains('terima kasih') || lower.contains('makasih')) {
      return 'Sama-sama! 😊 Senang bisa membantu. Jangan ragu untuk tanya lagi ya!';
    } else {
      final responses = [
        'Pertanyaan yang menarik! Aku sedang menganalisis informasi untuk memberikan jawaban terbaik untukmu. 🧠',
        'Hmm, itu pertanyaan yang bagus! Berdasarkan pengetahuanku, topik ini memang cukup luas. Bisa ceritakan lebih spesifik?',
        'Aku mengerti pertanyaanmu. Mari kita bahas bersama — apakah kamu ingin informasi umum atau ada aspek tertentu yang ingin didalami? 🔍',
        'Baik, aku akan bantu! Pertanyaanmu sangat relevan. Jawaban singkatnya: itu bergantung pada konteksnya. Mau elaborasi lebih lanjut?',
      ];
      return responses[DateTime.now().second % responses.length];
    }
  }

  String _timeNow() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFF075E54),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF25D366),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.smart_toy, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Wit AI', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Asisten Kecerdasan Buatan', style: TextStyle(color: Color(0xFFB2ECA0), fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        // Messages
        Expanded(
          child: Container(
            color: const Color(0xFFECE5DD),
            child: ListView.builder(
              controller: _scrollCtrl,
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (_, i) {
                if (_isTyping && i == _messages.length) {
                  return _buildTypingIndicator();
                }
                final msg = _messages[i];
                return _buildWitBubble(msg);
              },
            ),
          ),
        ),
        // Input
        Container(
          color: const Color(0xFFF0F0F0),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                  child: TextField(
                    controller: _ctrl,
                    decoration: const InputDecoration(
                      hintText: 'Tanya Wit sesuatu...',
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
                  decoration: const BoxDecoration(color: Color(0xFF25D366), shape: BoxShape.circle),
                  child: const Icon(Icons.send, color: Colors.white, size: 22),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWitBubble(WitMessage msg) {
    return Align(
      alignment: msg.isFromWit ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
        decoration: BoxDecoration(
          color: msg.isFromWit ? Colors.white : const Color(0xFFDCF8C6),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: msg.isFromWit ? const Radius.circular(0) : const Radius.circular(12),
            bottomRight: msg.isFromWit ? const Radius.circular(12) : const Radius.circular(0),
          ),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 2, offset: const Offset(0, 1))],
        ),
        child: Column(
          crossAxisAlignment: msg.isFromWit ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            if (msg.isFromWit) ...[
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.smart_toy, size: 14, color: Color(0xFF25D366)),
                  SizedBox(width: 4),
                  Text('Wit AI', style: TextStyle(color: Color(0xFF25D366), fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 4),
            ],
            Text(msg.text, style: const TextStyle(fontSize: 14, color: Colors.black87)),
            if (msg.timestamp.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(msg.timestamp, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 2)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.smart_toy, size: 14, color: Color(0xFF25D366)),
            const SizedBox(width: 8),
            const Text('Wit sedang mengetik', style: TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(width: 4),
            _DotIndicator(),
          ],
        ),
      ),
    );
  }
}

class _DotIndicator extends StatefulWidget {
  @override
  State<_DotIndicator> createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<_DotIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600))..repeat(reverse: true);
    _anim = Tween<double>(begin: 0, end: 1).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) => Container(
          width: 6, height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3 + 0.7 * (((_anim.value + i / 3) % 1))),
            shape: BoxShape.circle,
          ),
        )),
      ),
    );
  }
}
