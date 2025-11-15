import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:yaqeen/Islami/modules/home/quran/quran__details/verse_widget.dart';

import '../constant_and_view/constant.dart';
import 'basmala_widget.dart';

class SuraContent extends StatelessWidget {
  final int suraIndex;
  final List arabic;
  final bool mushafView;

  const SuraContent({
    Key? key,
    required this.suraIndex,
    required this.arabic,
    required this.mushafView,
  }) : super(key: key);

  int calculatePreviousVerses() {
    int previous = 0;
    for (int i = 0; i < suraIndex; i++) {
      previous += noOfVerses[i];
    }
    return previous;
  }

  @override
  Widget build(BuildContext context) {
    int previousVerses = calculatePreviousVerses();
    int lengthOfSura = noOfVerses[suraIndex];

    if (mushafView) {
      return ScrollablePositionedList.builder(
        itemCount: lengthOfSura,
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemBuilder: (context, index) {
          bool showBasmala = index == 0 && suraIndex != 0 && suraIndex != 8;
          return Column(
            children: [
              if (showBasmala) BasmalaWidget(color: Theme.of(context).colorScheme.onPrimary),
              VerseWidget(
                text: arabic[index + previousVerses]['aya_text'],
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ],
          );
        },
      );
    } else {
      String fullSura = '';
      for (int i = 0; i < lengthOfSura; i++) {
        fullSura += arabic[i + previousVerses]['aya_text'];
      }

      return ListView(
        children: [
          if (suraIndex != 0 && suraIndex != 8)
            BasmalaWidget(color: Theme.of(context).colorScheme.onSurface),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              fullSura,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: mushafFontSize,
                fontFamily: arabicFont,
                color: Color(0xffE2BE7F),
              ),
            ),
          ),
        ],
      );
    }
  }
}
