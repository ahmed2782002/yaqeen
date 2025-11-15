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
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;

    return Column(
      children: [
        Text(
          widget.radios.name ?? "",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
          textAlign: TextAlign.center,

        ),
        SizedBox(height: mediaQuery.height * .08),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: toggleAudio,
              iconSize: 50,
              color: Colors.white70,
              icon: Icon(

                  isPlaying ? Icons.pause :
                  Icons.play_arrow),
            ),
          ],
        ),
      ],
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
      print("خطأ أثناء تشغيل الصوت: $e");
    }
  }

  Future<void> stop() async {
    await widget.audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }
}
