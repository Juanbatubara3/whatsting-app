import 'package:flutter/material.dart';
import '../models/models.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  final List<StatusModel> _myStatuses = [];
  final List<StatusModel> _statuses = List.from(dummyStatuses);

  void _showAddStatusDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Tambah Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatusTypeButton(
                  icon: Icons.text_fields,
                  label: 'Teks',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pop(context);
                    _showTextStatusDialog();
                  },
                ),
                _StatusTypeButton(
                  icon: Icons.photo_camera,
                  label: 'Foto',
                  color: Colors.green,
                  onTap: () {
                    Navigator.pop(context);
                    _showMediaStatusDialog('Foto');
                  },
                ),
                _StatusTypeButton(
                  icon: Icons.videocam,
                  label: 'Video',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.pop(context);
                    _showMediaStatusDialog('Video');
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showTextStatusDialog() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Status Teks'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(hintText: 'Tulis status kamu...'),
          maxLines: 3,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF25D366)),
            onPressed: () {
              if (ctrl.text.isNotEmpty) {
                setState(() {
                  _myStatuses.insert(0, StatusModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    contactName: 'Status saya',
                    statusContent: ctrl.text,
                    timestamp: 'Baru saja',
                    hasNewStatus: true,
                    avatarUrl: currentUser.avatarUrl,
                  ));
                });
              }
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Status berhasil ditambahkan!'), backgroundColor: Color(0xFF25D366)),
              );
            },
            child: const Text('Posting', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showMediaStatusDialog(String type) {
    final List<String> dummyImages = [
      'https://picsum.photos/seed/status1/400/700',
      'https://picsum.photos/seed/status2/400/700',
      'https://picsum.photos/seed/status3/400/700',
    ];
    final List<String> dummyVideos = [
      'https://picsum.photos/seed/vid1/400/700',
      'https://picsum.photos/seed/vid2/400/700',
    ];
    final mediaUrls = type == 'Foto' ? dummyImages : dummyVideos;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Pilih $type'),
        content: SizedBox(
          width: double.maxFinite,
          height: 200,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8),
            itemCount: mediaUrls.length,
            itemBuilder: (_, i) => GestureDetector(
              onTap: () {
                setState(() {
                  _myStatuses.insert(0, StatusModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    contactName: 'Status saya',
                    statusContent: mediaUrls[i],
                    timestamp: 'Baru saja',
                    hasNewStatus: true,
                    avatarUrl: currentUser.avatarUrl,
                  ));
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Status $type berhasil ditambahkan!'), backgroundColor: const Color(0xFF25D366)),
                );
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(type == 'Foto' ? Icons.image : Icons.videocam, size: 40, color: Colors.grey),
                    const SizedBox(height: 8),
                    Text('${type} ${i + 1}', style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(currentUser.avatarUrl),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: const BoxDecoration(
                    color: Color(0xFF25D366),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
          title: const Text('Status saya', style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(
            _myStatuses.isEmpty ? 'Ketuk untuk menambah status' : '${_myStatuses.length} status • ${_myStatuses.first.timestamp}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          onTap: () => _showAddStatusDialog(context),
        ),
        if (_myStatuses.isNotEmpty) ...[
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Status Saya', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13)),
          ),
          ..._myStatuses.map((status) => ListTile(
            leading: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF25D366), width: 3),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(backgroundImage: NetworkImage(status.avatarUrl)),
              ),
            ),
            title: Text(status.contactName, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(status.timestamp, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            onTap: () => _showStatusView(context, status),
          )),
        ],
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('Pembaruan Terkini', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13)),
        ),
        ..._statuses.map((status) => ListTile(
          leading: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: status.hasNewStatus ? const Color(0xFF25D366) : Colors.grey, width: 3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: CircleAvatar(backgroundImage: NetworkImage(status.avatarUrl)),
            ),
          ),
          title: Text(status.contactName, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(status.timestamp, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          onTap: () => _showStatusView(context, status),
        )),
      ],
    );
  }

  void _showStatusView(BuildContext context, StatusModel status) {
    final bool isImage = status.statusContent.contains('picsum') || status.statusContent.contains('http');
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black87,
        child: Stack(
          children: [
            if (isImage)
              Image.network(status.statusContent, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
            else
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black87,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(status.statusContent, style: const TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center),
                  ),
                ),
              ),
            Positioned(
              top: 20,
              left: 20,
              child: Row(
                children: [
                  CircleAvatar(radius: 20, backgroundImage: NetworkImage(status.avatarUrl)),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(status.contactName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text(status.timestamp, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Tutup', style: TextStyle(color: Color(0xFF25D366), fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusTypeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _StatusTypeButton({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
            child: Icon(icon, size: 30, color: color),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}