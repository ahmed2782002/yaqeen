import 'package:flutter/material.dart';

class BasmalaWidget extends StatelessWidget {
  final Color? color;
  const BasmalaWidget({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Center(
        child: Text(
          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: 'me_quran',
            fontSize: 30,
            color:Color(0xffE2BE7F) ,
          ),
        ),
      ),
    );
  }
}
