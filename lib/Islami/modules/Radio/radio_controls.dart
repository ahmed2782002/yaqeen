import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RadioControls extends StatefulWidget {
  final List<dynamic> radios;
  final int initialIndex;
  final ValueChanged<int>? onIndexChanged; // لإبلاغ الـ parent بتغيير المحطة

  const RadioControls({
    super.key,
    required this.radios,
    this.initialIndex = 0,
    this.onIndexChanged,
  });

  @override
  State<RadioControls> createState() => _RadioControlsState();
}

class _RadioControlsState extends State<RadioControls> {
  late AudioPlayer _audioPlayer;
  late int _currentIndex;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _currentIndex = widget.initialIndex;
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _changeStation(int newIndex) async {
    await _audioPlayer.stop(); // وقف المحطة الحالية
    setState(() {
      _currentIndex = newIndex;
      _isPlaying = false; // مؤقتاً لعمل setState قبل التشغيل
    });

    // شغل المحطة الجديدة مباشرة
    final newUrl = widget.radios[_currentIndex].url;
    if (newUrl != null) {
      await _audioPlayer.play(UrlSource(newUrl));
      setState(() => _isPlaying = true);
    }

    // نبلغ الـ parent (RadioView) إن المحطة اتغيرت
    widget.onIndexChanged?.call(newIndex);
  }

  Future<void> _togglePlayPause() async {
    final currentUrl = widget.radios[_currentIndex].url;
    if (currentUrl == null) return;

    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(currentUrl));
    }

    setState(() => _isPlaying = !_isPlaying);
  }

  Widget _controlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary.withOpacity(.15),
        ),
        child: Icon(
          icon,
          size: 32,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  Widget _playPauseButton() {
    return InkWell(
      onTap: _togglePlayPause,
      borderRadius: BorderRadius.circular(60),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Theme.of(context).colorScheme.primary.withOpacity(.4),
            ),
          ],
        ),
        child: Icon(
          _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.radios.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous
        _controlButton(
          icon: Icons.skip_previous_rounded,
          onTap: () {
            final newIndex =
                (_currentIndex - 1 + widget.radios.length) % widget.radios.length;
            _changeStation(newIndex);
          },
        ),
        const SizedBox(width: 25),

        // Play / Pause
        _playPauseButton(),

        const SizedBox(width: 25),

        // Next
        _controlButton(
          icon: Icons.skip_next_rounded,
          onTap: () {
            final newIndex = (_currentIndex + 1) % widget.radios.length;
            _changeStation(newIndex);
          },
        ),
      ],
    );
  }

  // Getter اختياري لو عايز تستخدمه من بره
  dynamic get currentRadio => widget.radios[_currentIndex];
  bool get isPlaying => _isPlaying;
}