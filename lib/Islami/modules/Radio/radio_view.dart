import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/cubit/radio_cubit.dart';
import '../../../data/cubit/radio_state.dart';
import '../../../data/radio_repository.dart';


class RadioView extends StatefulWidget {
  const RadioView({super.key});

  @override
  State<RadioView> createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView> {
  late AudioPlayer audioPlayer;
  int currentRadioIndex = 0;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playRadio(String url) async {
    try {
      await audioPlayer.stop(); // وقف أي راديو شغال
      await audioPlayer.play(UrlSource(url));
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> stopRadio() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => RadioCubit(RadioRepository())..getRadios(),
      child: BlocBuilder<RadioCubit, RadioState>(
        builder: (context, state) {
          if (state is RadioLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RadioError) {
            return Center(child: Text(state.message));
          } else if (state is RadioSuccess) {
            var radios = state.radios;

            if (radios.isEmpty) {
              return const Center(child: Text("لا توجد محطات راديو"));
            }

            return Stack(
              children: [
                // الخلفية
                Container(
                  width: mediaQuery.width,
                  height: mediaQuery.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/image.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                // محتوى الراديو
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    // اسم الراديو
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        radios[currentRadioIndex].name ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // أزرار التحكم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Previous
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white24,
                          child: IconButton(
                            icon: const Icon(Icons.skip_previous),
                            color: Colors.white,
                            iconSize: 30,
                            onPressed: () async {
                              int newIndex = (currentRadioIndex - 1 + radios.length) % radios.length;
                              await playRadio(radios[newIndex].url ?? "");
                              setState(() {
                                currentRadioIndex = newIndex;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 25),
                        // Play / Pause
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white24,
                          child: IconButton(
                            iconSize: 40,
                            color: Colors.white,
                            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                            onPressed: () async {
                              if (isPlaying) {
                                await stopRadio();
                              } else {
                                await playRadio(radios[currentRadioIndex].url ?? "");
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 25),
                        // Next
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white24,
                          child: IconButton(
                            icon: const Icon(Icons.skip_next),
                            color: Colors.white,
                            iconSize: 30,
                            onPressed: () async {
                              int newIndex = (currentRadioIndex + 1) % radios.length;
                              await playRadio(radios[newIndex].url ?? "");
                              setState(() {
                                currentRadioIndex = newIndex;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
