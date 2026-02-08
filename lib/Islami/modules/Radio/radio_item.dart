import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../data/model/radiosModel.dart';

class RadioItem extends StatefulWidget {
  final Radios radios;
  final AudioPlayer audioPlayer;

  const RadioItem({
    super.key,
    required this.radios,
    required this.audioPlayer,
  });

  @override
  _RadioItemState createState() => _RadioItemState();
}

class _RadioItemState extends State<RadioItem> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.white24,
      child: IconButton(
        iconSize: 40,
        color: Colors.white,
        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
        onPressed: toggleAudio,
      ),
    );
  }

  void toggleAudio() {
    if (isPlaying) {
      stop();
    } else {
      play();
    }
  }

  Future<void> play() async {
    try {
      await widget.audioPlayer.play(UrlSource(widget.radios.url ?? ""));
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> stop() async {
    await widget.audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }
}
