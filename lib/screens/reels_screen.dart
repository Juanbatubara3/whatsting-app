import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/models.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> with AutomaticKeepAliveClientMixin {
  late PageController _pageCtrl;
  late List<ReelsModel> _reels;
  late List<VideoPlayerController?> _controllers;
  int _currentIndex = 0;
  bool _isMuted = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _reels = List.from(dummyReels);
    _pageCtrl = PageController();
    _controllers = List.generate(_reels.length, (index) => null);
    _initializeVideo(0);
  }

  Future<void> _initializeVideo(int index) async {
    if (index >= _reels.length) return;
    if (_controllers[index] != null) return;

    try {
      final VideoPlayerController controller;
      if (_reels[index].videoUrl.startsWith('assets/')) {
        controller = VideoPlayerController.asset(_reels[index].videoUrl);
      } else {
        controller = VideoPlayerController.networkUrl(
          Uri.parse(_reels[index].videoUrl),
        );
      }

      await controller.initialize();

      if (mounted) {
        controller.setLooping(true);
        controller.setVolume(_isMuted ? 0 : 1);

        setState(() {
          _controllers[index] = controller;
        });

        if (_currentIndex == index) {
          await controller.play();
        }
      }
    } catch (e) {
      debugPrint('Error initializing video $index: $e');
    }
  }

  void _onPageChanged(int index) async {
    if (_currentIndex == index) return;

    if (_currentIndex < _controllers.length && _controllers[_currentIndex] != null) {
      await _controllers[_currentIndex]!.pause();
    }

    setState(() {
      _currentIndex = index;
    });

    await _initializeVideo(index);

    if (index < _controllers.length && _controllers[index] != null && mounted) {
      await _controllers[index]!.play();
    }
  }

  void _toggleLike(int index) {
    setState(() {
      if (_reels[index].isLiked) {
        _reels[index].isLiked = false;
        _reels[index].likes--;
      } else {
        _reels[index].isLiked = true;
        _reels[index].likes++;
      }
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      if (_currentIndex < _controllers.length && _controllers[_currentIndex] != null) {
        _controllers[_currentIndex]!.setVolume(_isMuted ? 0 : 1);
      }
    });
  }

  void _togglePlayPause() {
    if (_currentIndex >= _controllers.length) return;
    final VideoPlayerController? controller = _controllers[_currentIndex];
    if (controller == null) return;

    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    setState(() {});
  }

  @override
  void dispose() {
    for (VideoPlayerController? controller in _controllers) {
      controller?.dispose();
    }
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PageView.builder(
      controller: _pageCtrl,
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      itemCount: _reels.length,
      itemBuilder: (BuildContext context, int index) {
        final ReelsModel reel = _reels[index];
        final VideoPlayerController? controller = _controllers[index];

        return Container(
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              if (controller != null && controller.value.isInitialized)
                GestureDetector(
                  onTap: _togglePlayPause,
                  child: VideoPlayer(controller),
                )
              else
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(color: Colors.white),
                      SizedBox(height: 16),
                      Text(
                        'Memuat video...',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),

              if (controller != null && controller.value.isInitialized && !controller.value.isPlaying)
                Center(
                  child: GestureDetector(
                    onTap: _togglePlayPause,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.play_arrow, color: Colors.white, size: 40),
                    ),
                  ),
                ),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text(
                    'Reels',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  foregroundColor: Colors.white,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                      onPressed: _toggleMute,
                    ),
                    const IconButton(icon: Icon(Icons.camera_alt_outlined), onPressed: null),
                  ],
                ),
              ),

              Positioned(
                bottom: 80,
                left: 16,
                right: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: const Color(0xFF25D366),
                          child: Text(
                            reel.creatorName.length > 1
                                ? reel.creatorName[1].toUpperCase()
                                : 'U',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          reel.creatorName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Berhasil mengikuti!'),
                                backgroundColor: Color(0xFF25D366),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                            minimumSize: const Size(0, 28),
                          ),
                          child: const Text('Ikuti', style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      reel.description,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (controller != null && controller.value.isInitialized) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          const Icon(Icons.play_arrow, size: 14, color: Colors.white70),
                          const SizedBox(width: 4),
                          Text(
                            _formatDuration(controller.value.duration),
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: FractionallySizedBox(
                                widthFactor: controller.value.duration.inMilliseconds > 0
                                    ? controller.value.position.inMilliseconds /
                                        controller.value.duration.inMilliseconds
                                    : 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF25D366),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              Positioned(
                right: 12,
                bottom: 80,
                child: Column(
                  children: <Widget>[
                    _ActionBtn(
                      icon: reel.isLiked ? Icons.favorite : Icons.favorite_border,
                      label: _formatCount(reel.likes),
                      color: reel.isLiked ? Colors.red : Colors.white,
                      onTap: () => _toggleLike(index),
                    ),
                    const SizedBox(height: 20),
                    _ActionBtn(
                      icon: Icons.comment_outlined,
                      label: _formatCount(reel.comments),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fitur komentar sedang dikembangkan'),
                            backgroundColor: Color(0xFF25D366),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _ActionBtn(
                      icon: Icons.send_outlined,
                      label: 'Bagikan',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Fitur bagikan sedang dikembangkan'),
                            backgroundColor: Color(0xFF25D366),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _ActionBtn(
                      icon: Icons.more_vert,
                      label: '',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Menu sedang dikembangkan'),
                            backgroundColor: Color(0xFF25D366),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              if (controller != null && controller.value.isInitialized && controller.value.isPlaying)
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: _togglePlayPause,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.pause, color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Ketuk untuk pause',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    final int minutes = duration.inMinutes.remainder(60);
    final int seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String _formatCount(int count) {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    this.color = Colors.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            color: color,
            size: 30,
            shadows: const <Shadow>[Shadow(color: Colors.black54, blurRadius: 4)],
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                shadows: <Shadow>[Shadow(color: Colors.black54, blurRadius: 4)],
              ),
            ),
          ],
        ],
      ),
    );
  }
}