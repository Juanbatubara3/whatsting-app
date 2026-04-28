import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

///================================================
/// REELS MODEL
///================================================

class ReelsModel {
  final String id;
  final String creatorName;
  final String description;
  final String videoUrl;

  int likes;
  int comments;
  bool isLiked;

  ReelsModel({
    required this.id,
    required this.creatorName,
    required this.description,
    required this.videoUrl,
    required this.likes,
    required this.comments,
    this.isLiked = false,
  });
}

final List<ReelsModel> dummyReels = [
  ReelsModel(
    id: '1',
    creatorName: '@revaldo_dev',
    description: 'Tutorial Flutter BottomNavigationBar 🔥',
    videoUrl: 'assets/videos/reels1.mp4',
    likes: 1234,
    comments: 89,
  ),
  ReelsModel(
    id: '2',
    creatorName: '@nicolas_code',
    description: 'Bikin Reels Clone pakai Flutter 🚀',
    videoUrl: 'assets/videos/reels2.mp4',
    likes: 876,
    comments: 45,
  ),
  ReelsModel(
    id: '3',
    creatorName: '@michael_tech',
    description: 'Marketplace Flutter gampang 🛒',
    videoUrl: 'assets/videos/reels3.mp4',
    likes: 2100,
    comments: 132,
  ),
];

///================================================
/// REELS PLAYER
///================================================

class ReelsPlayer extends StatefulWidget {
  final ReelsModel reel;

  const ReelsPlayer({
    super.key,
    required this.reel,
  });

  @override
  State<ReelsPlayer> createState() => _ReelsPlayerState();
}

class _ReelsPlayerState extends State<ReelsPlayer> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      if (widget.reel.videoUrl.startsWith('assets/')) {
        _videoController = VideoPlayerController.asset(widget.reel.videoUrl);
      } else {
        _videoController = VideoPlayerController.networkUrl(
          Uri.parse(widget.reel.videoUrl),
        );
      }

      await _videoController.initialize();

      if (!mounted) return;

      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        looping: true,
        autoInitialize: true,
        showControls: false,
        allowFullScreen: false,
        allowPlaybackSpeedChanging: false,
        aspectRatio: _videoController.value.aspectRatio == 0
            ? 9 / 16
            : _videoController.value.aspectRatio,
      );

      setState(() {
        loading = false;
      });
    } catch (e) {
      debugPrint("Video Error: $e");
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Chewie(controller: _chewieController!),

        Positioned(
          left: 15,
          right: 90,
          bottom: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.reel.creatorName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.reel.description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),

        Positioned(
          right: 15,
          bottom: 120,
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.reel.isLiked) {
                      widget.reel.likes--;
                    } else {
                      widget.reel.likes++;
                    }
                    widget.reel.isLiked = !widget.reel.isLiked;
                  });
                },
                icon: Icon(
                  widget.reel.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              Text(
                "${widget.reel.likes}",
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 32),
              Text(
                "${widget.reel.comments}",
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Icon(Icons.share, color: Colors.white, size: 32),
            ],
          ),
        ),
      ],
    );
  }
}

///================================================
/// STATUS MODEL
///================================================

class StatusModel {
  final String id;
  final String contactName;
  final String statusContent;
  final String timestamp;
  final bool hasNewStatus;
  final String avatarUrl;

  const StatusModel({
    required this.id,
    required this.contactName,
    required this.statusContent,
    required this.timestamp,
    required this.hasNewStatus,
    required this.avatarUrl,
  });
}

final List<StatusModel> dummyStatuses = [
  StatusModel(
    id: '1',
    contactName: 'Nicolas Nababan',
    statusContent: 'Lagi ngoding fitur reels 🚀',
    timestamp: '5 menit lalu',
    hasNewStatus: true,
    avatarUrl: 'https://ui-avatars.com/api/?name=Nicolas+Nababan',
  ),
  StatusModel(
    id: '2',
    contactName: 'Michael Batubara',
    statusContent: 'Marketplace done 🛒',
    timestamp: '20 menit lalu',
    hasNewStatus: true,
    avatarUrl: 'https://ui-avatars.com/api/?name=Michael+Batubara',
  ),
  StatusModel(
    id: '3',
    contactName: 'Dosen Pembimbing',
    statusContent: 'Semangat ngoding 💪',
    timestamp: '1 jam lalu',
    hasNewStatus: false,
    avatarUrl: 'https://ui-avatars.com/api/?name=Dosen+Pembimbing',
  ),
];

///================================================
/// WIT MESSAGE
///================================================

class WitMessage {
  final String text;
  final bool isFromWit;
  final String timestamp;

  const WitMessage({
    required this.text,
    required this.isFromWit,
    required this.timestamp,
  });
}

///================================================
/// USER MODEL
///================================================

class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String bio;
  final String avatarUrl;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.bio,
    required this.avatarUrl,
  });
}

const currentUser = UserModel(
  id: 'me',
  name: 'Revaldo Situmorang',
  phone: '+62 81234567890',
  email: 'revaldo@whatsting.app',
  bio: 'Ketua Kelompok Deeptri 🚀',
  avatarUrl: 'https://ui-avatars.com/api/?name=Revaldo+Situmorang',
);