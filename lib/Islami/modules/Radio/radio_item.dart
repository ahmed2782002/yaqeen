import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../data/model/radiosModel.dart';

class RadioItem extends StatefulWidget {
  final Radios radios;
  final AudioPlayer audioPlayer;

  const RadioItem({super.key, required this.radios, required this.audioPlayer});

  @override
  _RadioItemState createState() => _RadioItemState();
}

class _RadioItemState extends State<RadioItem> {
  bool isPlaying = false; // متغير لتخزين حالة التشغيل

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(widget.radios.name ?? "", style: theme.textTheme.bodyMedium),
        SizedBox(
          height: mediaQuery.height * .08,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                if (isPlaying) {
                  stop(); // إيقاف الصوت
                } else {
                  play(); // تشغيل الصوت
                }
              },
              iconSize: 60,
              color: theme.colorScheme.onPrimary,
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow, // تغيير الأيقونة بناءً على الحالة
              ),
            ),
          ],
        ),
      ],
    );
  }

  void play() async {
    await widget.audioPlayer.play(UrlSource(widget.radios.url ?? ""));
    setState(() {
      isPlaying = true; // تحديث الحالة إلى تشغيل
    });
  }

  void stop() async {
    await widget.audioPlayer.stop();
    setState(() {
      isPlaying = false; // تحديث الحالة إلى إيقاف
    });
  }
}
