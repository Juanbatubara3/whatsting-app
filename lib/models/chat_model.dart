class ChatModel {
  final String id;
  final String contactName;
  final String lastMessage;
  final String timestamp;
  final String avatarUrl;
  final int unreadCount;

  const ChatModel({
    required this.id,
    required this.contactName,
    required this.lastMessage,
    required this.timestamp,
    required this.avatarUrl,
    this.unreadCount = 0,
  });
}

class MessageModel {
  final String id;
  final String text;
  final bool isMine;
  final String timestamp;
  final String status; // 'sent', 'delivered', 'read'

  const MessageModel({
    required this.id,
    required this.text,
    required this.isMine,
    required this.timestamp,
    this.status = 'sent',
  });
}

final List<ChatModel> dummyChats = [
  const ChatModel(
    id: '1',
    contactName: 'Nicolas Nababan',
    lastMessage: 'Hei, gimana progressnya?',
    timestamp: '10:30',
    avatarUrl: 'https://ui-avatars.com/api/?name=Nicolas+Nababan&background=4CAF50&color=fff',
    unreadCount: 2,
  ),
  const ChatModel(
    id: '2',
    contactName: 'Michael Batubara',
    lastMessage: 'Udah push ke GitHub ya',
    timestamp: '09:45',
    avatarUrl: 'https://ui-avatars.com/api/?name=Michael+Batubara&background=2196F3&color=fff',
    unreadCount: 0,
  ),
  const ChatModel(
    id: '3',
    contactName: 'Dosen Pembimbing',
    lastMessage: 'Presentasi minggu depan jam 9',
    timestamp: 'Kemarin',
    avatarUrl: 'https://ui-avatars.com/api/?name=Dosen+Pembimbing&background=9C27B0&color=fff',
    unreadCount: 1,
  ),
  const ChatModel(
    id: '4',
    contactName: 'Kelompok Deeptri',
    lastMessage: 'Revaldo: Meeting jam 3 sore',
    timestamp: 'Kemarin',
    avatarUrl: 'https://ui-avatars.com/api/?name=Kelompok+Deeptri&background=FF5722&color=fff',
    unreadCount: 5,
  ),
  const ChatModel(
    id: '5',
    contactName: 'Mama',
    lastMessage: 'Sudah makan siang?',
    timestamp: 'Sen',
    avatarUrl: 'https://ui-avatars.com/api/?name=Mama&background=E91E63&color=fff',
    unreadCount: 0,
  ),
];
