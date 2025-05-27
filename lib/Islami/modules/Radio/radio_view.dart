import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:yaqeen/Islami/modules/Radio/radio_item.dart';

import '../../../data/api_mananger.dart';
import '../../../data/model/radiosModel.dart';

class RadioView extends StatefulWidget {
  const RadioView({super.key});

  @override
  State<RadioView> createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView> {
  late AudioPlayer audioPlayer;
  int currentRadioIndex = 0; // لحفظ الفهرس الحالي للراديو

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Image.asset(
          "assets/images/radio.png",
          width: mediaQuery.width * .75,
        ),
        SizedBox(
          height: mediaQuery.height * .08,
        ),
        Spacer(),
        FutureBuilder<List<Radios>?>( // جلب المحطات
            future: ApiManager.GetRadios(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var radios = snapshot.data ?? [];
                return SizedBox(
                  height: mediaQuery.height * .3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              currentRadioIndex = (currentRadioIndex - 1) % radios.length;
                            });
                          },
                          iconSize: 40,
                          color: Theme.of(context).colorScheme.onPrimary,
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      RadioItem(
                        radios: radios[currentRadioIndex],
                        audioPlayer: audioPlayer,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentRadioIndex = (currentRadioIndex + 1) % radios.length;
                          });
                        },
                        iconSize: 40,
                        color: Theme.of(context).colorScheme.onPrimary,
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                );
              }
            }),
        Spacer(),
      ],
    );
  }
}

