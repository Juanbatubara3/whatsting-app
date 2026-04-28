import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang WhatsTing'),
        backgroundColor: const Color(0xFF075E54),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 36),
              color: const Color(0xFF075E54),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF25D366),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 44),
                  ),
                  const SizedBox(height: 12),
                  const Text('WhatsTing', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  const Text('v1.0.0', style: TextStyle(color: Color(0xFFB2ECA0), fontSize: 14)),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Aplikasi Pesan & Sosial Media Serba Bisa',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            // Description
            Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Tentang Aplikasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF075E54))),
                      SizedBox(height: 8),
                      Text(
                        'WhatsTing adalah aplikasi komunikasi mobile yang mengintegrasikan fitur terbaik dari berbagai platform populer. Dibangun dengan Flutter, WhatsTing menggabungkan chat instan, status, reels, marketplace, dan asisten AI dalam satu ekosistem yang terpadu.',
                        style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Team
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tim Pengembang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF075E54))),
                      const SizedBox(height: 4),
                      const Text('Kelompok Deeptri | TI2115', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      const Divider(height: 24),
                      _TeamMember(
                        name: 'Revaldo Situmorang',
                        nim: '241130772',
                        role: 'Ketua | Login, Chat & Navigasi',
                        color: const Color(0xFF075E54),
                      ),
                      const SizedBox(height: 12),
                      _TeamMember(
                        name: 'Nicolas Nababan',
                        nim: '241130997',
                        role: 'Home, Status & Reels',
                        color: Colors.blue[700]!,
                      ),
                      const SizedBox(height: 12),
                      _TeamMember(
                        name: 'Michael J.M Batubara',
                        nim: '241131014',
                        role: 'Marketplace, Wit AI & Profil',
                        color: Colors.purple[700]!,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Features
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Fitur Utama', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF075E54))),
                      const SizedBox(height: 12),
                      ...[
                        ('💬', 'Chat & Pesan Instan'),
                        ('🔵', 'Status Stories'),
                        ('🎬', 'Reels Video Pendek'),
                        ('🛒', 'Marketplace Belanja'),
                        ('🤖', 'Wit AI Assistant'),
                        ('👤', 'Profil & Pengaturan'),
                      ].map((f) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Text(f.$1, style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 12),
                            Text(f.$2, style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Tech stack
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Teknologi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF075E54))),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: ['Flutter', 'Dart', 'Material Design', 'StatefulWidget', 'Navigator'].map(
                          (tech) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF25D366).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFF25D366), width: 1),
                            ),
                            child: Text(tech, style: const TextStyle(color: Color(0xFF075E54), fontSize: 13, fontWeight: FontWeight.w500)),
                          ),
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('© 2026 Kelompok Deeptri | TI2115', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _TeamMember extends StatelessWidget {
  final String name;
  final String nim;
  final String role;
  final Color color;

  const _TeamMember({required this.name, required this.nim, required this.role, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: color,
          child: Text(name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(nim, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              Text(role, style: TextStyle(color: color, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
