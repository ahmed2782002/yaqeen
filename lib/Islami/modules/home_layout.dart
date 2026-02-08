import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'Hadeth/hadeth_view.dart';
import 'Radio/radio_view.dart';
import 'Tasbeh/tasbeh.dart';
import 'home/Quran/quran_view.dart';

class HomeLayout extends StatefulWidget {
  static String routeName = "home layout";

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;

  List<Widget> screens = const [
    HomeQuran(),
    HadethView(),
    TasbehView(),
    RadioView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: screens[selectedIndex],
      ),

      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Color(0xFF262422),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: SalomonBottomBar(
            backgroundColor: Colors.transparent,
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            itemPadding:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            items: [
              _buildGlassItem("assets/images/Quran.png", "القرآن" ,
                  selectedIndex == 0,
                  isHadeth: false),
              _buildGlassItem("assets/images/hadth.png", "احاديث",
                  selectedIndex == 1,
                  isHadeth: true),
              _buildGlassItem("assets/images/sebha.png", "تسبيح",
                  selectedIndex == 2,
                  isHadeth: false),
              _buildGlassItem("assets/images/img.png", "رديو",
                  selectedIndex == 3,
                  isHadeth: false),
            ],
          ),
        ),
      ),
    );
  }

  SalomonBottomBarItem _buildGlassItem(String asset, String title, bool active,
      {bool isHadeth = false}) {
    return SalomonBottomBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: active ? Colors.white.withOpacity(0.25) : Colors.transparent,
          boxShadow: active
              ? [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            scale: active
                ? 1.5
                : isHadeth
                ? 1.5
                : 2.1,
            child: ImageIcon(
              AssetImage(asset),
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
          child: Text(title),
        ),
      ),
      selectedColor: Colors.white,
    );
  }
}
