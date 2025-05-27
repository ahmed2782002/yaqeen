import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../Core/Provider/app_provider.dart';

class TasbehView extends StatefulWidget {
  const TasbehView({super.key});

  @override
  State<TasbehView> createState() => _TasbehViewState();
}

class _TasbehViewState extends State<TasbehView> {
  int counter = 1;
  List<String> azkar = [
    "سبحان الله",
    "الحمدلله",
    "الله اكبر",
    "لا إله إلا الله"
  ];
  double angle = 0;

  int azkarCounter = 0;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    var appProvider = Provider.of<AppProvider>(context);

    return Container(
      width: mediaQuery.width,
      margin: EdgeInsets.only(top: mediaQuery.height * .12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -mediaQuery.height * .075,
                child: Padding(
                  padding: EdgeInsets.only(left: mediaQuery.width * .1),
                  child: Image.asset(
                    appProvider.isDarkEnabled()
                        ? "assets/images/sebha_head_dark.png"
                        : "assets/images/sebha_head.png",
                    height: mediaQuery.height * .1,
                    width: mediaQuery.width * .2,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  logic();
                },
                child: Transform.rotate(
                  angle: angle,
                  child: Image.asset(
                    appProvider.isDarkEnabled()
                        ? "assets/images/sebha_body_dark.png"
                        : "assets/images/body_sebha.png",
                    height: mediaQuery.height * .25,
                    width: mediaQuery.width * .53,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: mediaQuery.height * .05,
          ),
          Text(
            // the number of tasbeeh by local
            "عدد التسبيحات",
            style: theme.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(
            height: mediaQuery.height * .05,
          ),
          Container(
            padding: EdgeInsets.all(mediaQuery.height * 0.025),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: theme.primaryColor.withOpacity(.57),
            ),
            child: Text(
              counter.toString(),
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(
            height: mediaQuery.height * .05,
          ),
          ElevatedButton(
            onPressed: () {
              logic();
            },
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              backgroundColor: theme.colorScheme.onPrimary,
            ),
            child: Text(azkar[azkarCounter],
                style: TextStyle(
                    color: theme.colorScheme.onPrimaryContainer, fontSize: 30)),
          ),
        ],
      ),
    );
  }

  void logic() {
    if (counter == 33) {
      counter = 1;
      if (azkarCounter == 3) {
        azkarCounter = 0;
      } else {
        azkarCounter++;
      }
    } else {
      counter++;
    }
    angle += 10;
    setState(() {});
  }
}
