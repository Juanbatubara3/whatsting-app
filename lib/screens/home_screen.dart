import 'package:flutter/material.dart';
import 'chat_list_screen.dart';
import 'status_screen.dart';
import 'reels_screen.dart';
import 'marketplace_screen.dart';
import 'wit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    ChatListScreen(),
    StatusScreen(),
    ReelsScreen(),
    MarketplaceScreen(),
    WitScreen(),
  ];

  final List<String> _titles = ['WhatsTing', 'Status', 'Reels', 'Marketplace', 'Wit AI'];

  void _onTabTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex != 2
          ? AppBar(
              title: Text(
                _titles[_selectedIndex],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color(0xFF075E54),
              foregroundColor: Colors.white,
              actions: [
                if (_selectedIndex == 0) ...[
                  IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'profile') Navigator.pushNamed(context, '/profile');
                      if (value == 'about') Navigator.pushNamed(context, '/about');
                      if (value == 'logout') Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(value: 'profile', child: Text('Profil')),
                      const PopupMenuItem(value: 'about', child: Text('Tentang')),
                      const PopupMenuItem(value: 'logout', child: Text('Keluar')),
                    ],
                  ),
                ],
              ],
            )
          : null,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF075E54),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), activeIcon: Icon(Icons.chat_bubble), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.circle_outlined), activeIcon: Icon(Icons.circle), label: 'Status'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline), activeIcon: Icon(Icons.play_circle), label: 'Reels'),
          BottomNavigationBarItem(icon: Icon(Icons.store_outlined), activeIcon: Icon(Icons.store), label: 'Toko'),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy_outlined), activeIcon: Icon(Icons.smart_toy), label: 'Wit AI'),
        ],
      ),
    );
  }
}
