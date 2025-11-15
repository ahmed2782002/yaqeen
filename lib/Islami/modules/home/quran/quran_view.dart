import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaqeen/Islami/modules/home/prayer_time/prayer_times.dart';
import 'package:yaqeen/Islami/modules/home/widget_bar/search_bar.dart';
import 'constant_and_view/arabic_sura_number.dart';
import 'constant_and_view/constant.dart';
import 'quran__details/quran_details_view.dart';

class HomeQuran extends StatefulWidget {
  const HomeQuran({super.key});

  @override
  State<HomeQuran> createState() => _HomeQuranState();
}

class _HomeQuranState extends State<HomeQuran> {
  dynamic quranData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadQuran();
  }

  Future<void> loadQuran() async {
    final String response =
    await rootBundle.loadString("assets/hafs_smart_v8.json");
    final data = json.decode(response);
    final arabic = data["quran"];
    final malayalam = data["malayalam"];
    quranData = [arabic, malayalam];

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // الخلفية
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/Background_qraun.png",
              fit: BoxFit.cover,
            ),
          ),

          // المحتوى
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  SearchBarWidget(),
                  const SizedBox(height: 16),

                  // Prayer Time Widget
                  const PrayerTimeWidget(),
                  const SizedBox(height: 10),

                  // Quran List
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 30),
                      itemCount: 114,
                      itemBuilder: (context, index) {
                        final suraName = arabicName[index]['name'];
                        final ayahCount = noOfVerses[index];

                        return Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                fabIsClicked = false;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => QuranDetailsView(
                                      arabic: quranData[0],
                                      sura: index,
                                      suraName: suraName,
                                      ayah: 0,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  ArabicSuraNumber(i: index),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        suraName,
                                        style: const TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontFamily: 'quran',
                                          shadows: [
                                            Shadow(
                                              offset: Offset(.5, .5),
                                              blurRadius: 1.0,
                                              color: Color.fromARGB(
                                                  255, 130, 130, 130),
                                            )
                                          ],
                                        ),
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 8),
                                    child: Text(
                                      '$ayahCount آية',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white70,
                                        fontFamily: 'quran',
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(color: Colors.white),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
