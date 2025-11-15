import 'package:flutter/material.dart';
import '../constant_and_view/constant.dart';

class VerseWidget extends StatelessWidget {
  final String text;
  final Color color;

  const VerseWidget({Key? key, required this.text, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Padding جانبي
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(

              color: const Color(0xffE2BE7F), width: 1.5), // بوردر أبيض
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: arabicFontSize,
            fontFamily: arabicFont,
color: Colors.white
          ),
        ),
      ),
    );
  }
}
