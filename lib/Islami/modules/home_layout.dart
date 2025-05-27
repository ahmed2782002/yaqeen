import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '';
import '../Core/Provider/app_provider.dart';
import 'Hadeth/hadeth_view.dart';
import 'Quran/quran_view.dart';
import 'Radio/radio_view.dart';
import 'Settings/setting.dart';
import 'Tasbeh/tasbeh.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeLayout extends StatefulWidget {
  static String routeName = "home layout";

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIndex = 0;

  List<Widget> screens = const [
  QuranView(),
    HadethView(),
    TasbehView(),
    RadioView(),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);

    final local = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(appProvider.getBackgroundImage()),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(local.islami),
        ),
        body: screens[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/Quran.png"),
              ),
              label: local.quran,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/hadth.png"),
              ),
              label: local.hadeth,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/sebha.png"),
              ),
              label:local.tasbeh,
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/img.png"),
              ),
              label: local.radio,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: local.setting,
            ),
          ],
        ),
      ),
    );
  }
}
