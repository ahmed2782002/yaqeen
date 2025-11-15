import 'package:flutter/material.dart';

class TasbehView extends StatefulWidget {
  const TasbehView({super.key});

  @override
  State<TasbehView> createState() => _TasbehViewState();
}

class _TasbehViewState extends State<TasbehView> {
  int counter = 1;
  List<String> azkar = [
    "سُبْحَانَ اللَّهِ ",
    "الْحَمْدُ لِلَّهِ",
    "اللَّهُ أَكْبَرُ",
    "لَا إِلَهَ إِلَّا اللَّهُ"
  ];
  double angle = 0;
  int azkarCounter = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Background_sbaha.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Image.asset(
            "assets/images/logo.png",
            width: 300,
          ),

          Text(
            "سَبِّحِ اسْمَ رَبِّكَ الأعلى",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontFamily: 'Janna LT',
            ),
          ),

          const Spacer(),

          /// 🔹 السبحة
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              /// رأس السبحة
              Positioned(
                top: -size.height * 0.089,
                left: size.width * 0.226,
                child: Image.asset(
                  "assets/images/sabha.png",
                  height: size.height * 0.12,
                  width: size.width * 0.29,
                ),
              ),

              /// جسم السبحة (بيلف)
              GestureDetector(
                onTap: _onSebhaTap,
                child: Transform.rotate(
                  angle: angle,
                  child: Image.asset(
                    "assets/images/sbaha_body.png",
                    height: size.height * 0.35,
                    width: size.width * 0.75,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              /// النصوص الثابتة
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// العداد
                  GestureDetector(
                    onTap: _onSebhaTap,
                    child: Text(
                      counter.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// 🔹 الذكر: الضغط عليه يعمل دوران السبحة
                  GestureDetector(
                    onTap: _onSebhaTap,
                    child: Text(
                      azkar[azkarCounter],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontFamily: 'Janna LT',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 150),
        ],
      ),
    );
  }

  /// دالة الدوران والعدّ
  void _onSebhaTap() {
    setState(() {
      if (counter == 33) {
        counter = 1;
        azkarCounter = (azkarCounter + 1) % azkar.length;
      } else {
        counter++;
      }
      angle += 0.2; // السبحة تلف
    });
  }
}
