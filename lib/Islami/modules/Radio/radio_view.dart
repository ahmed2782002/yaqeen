import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/cubit/radio_cubit.dart';
import '../../../data/cubit/radio_state.dart';
import '../../../data/radio_repository.dart';
import 'radio_item.dart';

class RadioView extends StatefulWidget {
  const RadioView({super.key});

  @override
  State<RadioView> createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView> {
  late AudioPlayer audioPlayer;
  int currentRadioIndex = 0;

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

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  "assets/images/radio.png",
                  width: mediaQuery.width * .75,
                ),
                SizedBox(height: mediaQuery.height * .08),
                const Spacer(),
                SizedBox(
                  height: mediaQuery.height * .3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              currentRadioIndex =
                                  (currentRadioIndex - 1 + radios.length) %
                                      radios.length;
                            });
                          },
                          iconSize: 40,
                          color: Theme.of(context).colorScheme.onPrimary,
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      RadioItem(
                        radios: radios[currentRadioIndex],
                        audioPlayer: audioPlayer,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            currentRadioIndex =
                                (currentRadioIndex + 1) % radios.length;
                          });
                        },
                        iconSize: 40,
                        color: Theme.of(context).colorScheme.onPrimary,
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
