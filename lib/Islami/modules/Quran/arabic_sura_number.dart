import 'package:flutter/material.dart';

import 'package:yaqeen/Islami/modules/Quran/to_arabic_no_converter.dart';




class ArabicSuraNumber extends StatelessWidget {
  const ArabicSuraNumber({Key? key,required this.i}) : super(key: key);
    final int i;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Text("\uFD3E"+(i+1).toString().toArabicNumbers+"\uFD3F", style:  TextStyle(
        color:theme.colorScheme.onSurface ,
        fontFamily: 'me_quran',
        fontSize: 20,
        shadows: [
          Shadow(
            offset: Offset(.5, .5),
            blurRadius: 1.0,
            color: theme.colorScheme.onSurface,
          ),
        ]),);
  }
}
