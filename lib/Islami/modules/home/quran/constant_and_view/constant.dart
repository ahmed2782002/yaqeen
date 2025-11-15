import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// التحكم في التنقل بين السور والآيات
int bookmarkedAyah = 1;
int bookmarkedSura = 1;
bool fabIsClicked = true;

String removeTashkeel(String text) {
  final diacritics = RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED]');
  return text.replaceAll(diacritics, '');
}

final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

// إعدادات الخط
String arabicFont = 'quran';
double arabicFontSize = 28;
double mushafFontSize = 40;
// أسماء السور بالتشكيل الكامل كما في المصحف
List<Map> arabicName = [
  {"surah": "1", "name": "ٱلْفَاتِحَة"},
  {"surah": "2", "name": "ٱلْبَقَرَة"},
  {"surah": "3", "name": "آلِ عِمْرَان"},
  {"surah": "4", "name": "ٱلنِّسَاء"},
  {"surah": "5", "name": "ٱلْمَائِدَة"},
  {"surah": "6", "name": "ٱلْأَنْعَام"},
  {"surah": "7", "name": "ٱلْأَعْرَاف"},
  {"surah": "8", "name": "ٱلْأَنْفَال"},
  {"surah": "9", "name": "ٱلتَّوْبَة"},
  {"surah": "10", "name": "يُونُس"},
  {"surah": "11", "name": "هُود"},
  {"surah": "12", "name": "يُوسُف"},
  {"surah": "13", "name": "ٱلرَّعْد"},
  {"surah": "14", "name": "إِبْرَاهِيم"},
  {"surah": "15", "name": "ٱلْحِجْر"},
  {"surah": "16", "name": "ٱلنَّحْل"},
  {"surah": "17", "name": "ٱلْإِسْرَاء"},
  {"surah": "18", "name": "ٱلْكَهْف"},
  {"surah": "19", "name": "مَرْيَم"},
  {"surah": "20", "name": "طه"},
  {"surah": "21", "name": "ٱلْأَنْبِيَاء"},
  {"surah": "22", "name": "ٱلْحَجّ"},
  {"surah": "23", "name": "ٱلْمُؤْمِنُون"},
  {"surah": "24", "name": "ٱلنُّور"},
  {"surah": "25", "name": "ٱلْفُرْقَان"},
  {"surah": "26", "name": "ٱلشُّعَرَاء"},
  {"surah": "27", "name": "ٱلنَّمْل"},
  {"surah": "28", "name": "ٱلْقَصَص"},
  {"surah": "29", "name": "ٱلْعَنْكَبُوت"},
  {"surah": "30", "name": "ٱلرُّوم"},
  {"surah": "31", "name": "لُقْمَان"},
  {"surah": "32", "name": "ٱلسَّجْدَة"},
  {"surah": "33", "name": "ٱلْأَحْزَاب"},
  {"surah": "34", "name": "سَبَإ"},
  {"surah": "35", "name": "فَاطِر"},
  {"surah": "36", "name": "يس"},
  {"surah": "37", "name": "ٱلصَّافَّات"},
  {"surah": "38", "name": "ص"},
  {"surah": "39", "name": "ٱلزُّمَر"},
  {"surah": "40", "name": "غَافِر"},
  {"surah": "41", "name": "فُصِّلَت"},
  {"surah": "42", "name": "ٱلشُّورَى"},
  {"surah": "43", "name": "ٱلزُّخْرُف"},
  {"surah": "44", "name": "ٱلدُّخَان"},
  {"surah": "45", "name": "ٱلْجَاثِيَة"},
  {"surah": "46", "name": "ٱلْأَحْقَاف"},
  {"surah": "47", "name": "مُحَمَّد"},
  {"surah": "48", "name": "ٱلْفَتْح"},
  {"surah": "49", "name": "ٱلْحُجُرَات"},
  {"surah": "50", "name": "ق"},
  {"surah": "51", "name": "ٱلذَّارِيَات"},
  {"surah": "52", "name": "ٱلطُّور"},
  {"surah": "53", "name": "ٱلنَّجْم"},
  {"surah": "54", "name": "ٱلْقَمَر"},
  {"surah": "55", "name": "ٱلرَّحْمَٰن"},
  {"surah": "56", "name": "ٱلْوَاقِعَة"},
  {"surah": "57", "name": "ٱلْحَدِيد"},
  {"surah": "58", "name": "ٱلْمُجَادِلَة"},
  {"surah": "59", "name": "ٱلْحَشْر"},
  {"surah": "60", "name": "ٱلْمُمْتَحَنَة"},
  {"surah": "61", "name": "ٱلصَّفّ"},
  {"surah": "62", "name": "ٱلْجُمُعَة"},
  {"surah": "63", "name": "ٱلْمُنَافِقُون"},
  {"surah": "64", "name": "ٱلتَّغَابُن"},
  {"surah": "65", "name": "ٱلطَّلَاق"},
  {"surah": "66", "name": "ٱلتَّحْرِيم"},
  {"surah": "67", "name": "ٱلْمُلْك"},
  {"surah": "68", "name": "ٱلْقَلَم"},
  {"surah": "69", "name": "ٱلْحَاقَّة"},
  {"surah": "70", "name": "ٱلْمَعَارِج"},
  {"surah": "71", "name": "نُوح"},
  {"surah": "72", "name": "ٱلْجِنّ"},
  {"surah": "73", "name": "ٱلْمُزَّمِّل"},
  {"surah": "74", "name": "ٱلْمُدَّثِّر"},
  {"surah": "75", "name": "ٱلْقِيَامَة"},
  {"surah": "76", "name": "ٱلْإِنسَان"},
  {"surah": "77", "name": "ٱلْمُرْسَلَات"},
  {"surah": "78", "name": "ٱلنَّبَإ"},
  {"surah": "79", "name": "ٱلنَّازِعَات"},
  {"surah": "80", "name": "عَبَس"},
  {"surah": "81", "name": "ٱلتَّكْوِير"},
  {"surah": "82", "name": "ٱلْإِنفِطَار"},
  {"surah": "83", "name": "ٱلْمُطَفِّفِينَ"},
  {"surah": "84", "name": "ٱلْإِنْشِقَاق"},
  {"surah": "85", "name": "ٱلْبُرُوج"},
  {"surah": "86", "name": "ٱلطَّارِق"},
  {"surah": "87", "name": "ٱلْأَعْلَى"},
  {"surah": "88", "name": "ٱلْغَاشِيَة"},
  {"surah": "89", "name": "ٱلْفَجْر"},
  {"surah": "90", "name": "ٱلْبَلَد"},
  {"surah": "91", "name": "ٱلشَّمْس"},
  {"surah": "92", "name": "ٱللَّيْل"},
  {"surah": "93", "name": "ٱلضُّحَى"},
  {"surah": "94", "name": "ٱلشَّرْح"},
  {"surah": "95", "name": "ٱلتِّين"},
  {"surah": "96", "name": "ٱلْعَلَق"},
  {"surah": "97", "name": "ٱلْقَدْر"},
  {"surah": "98", "name": "ٱلْبَيِّنَة"},
  {"surah": "99", "name": "ٱلزَّلْزَلَة"},
  {"surah": "100", "name": "ٱلْعَادِيَات"},
  {"surah": "101", "name": "ٱلْقَارِعَة"},
  {"surah": "102", "name": "ٱلتَّكَاثُر"},
  {"surah": "103", "name": "ٱلْعَصْر"},
  {"surah": "104", "name": "ٱلْهُمَزَة"},
  {"surah": "105", "name": "ٱلْفِيل"},
  {"surah": "106", "name": "قُرَيْش"},
  {"surah": "107", "name": "ٱلْمَاعُون"},
  {"surah": "108", "name": "ٱلْكَوْثَر"},
  {"surah": "109", "name": "ٱلْكَافِرُون"},
  {"surah": "110", "name": "ٱلنَّصْر"},
  {"surah": "111", "name": "ٱلْمَسَد"},
  {"surah": "112", "name": "ٱلْإِخْلَاص"},
  {"surah": "113", "name": "ٱلْفَلَق"},
  {"surah": "114", "name": "ٱلنَّاس"},
];

// عدد آيات كل سورة
List<int> noOfVerses = [
  7, 286, 200, 176, 120, 165, 206, 75, 129, 109, 123, 111, 43, 52, 99, 128,
  111, 110, 98, 135, 112, 78, 118, 64, 77, 227, 93, 88, 69, 60, 34, 30, 73,
  54, 45, 83, 182, 88, 75, 85, 54, 53, 89, 59, 37, 35, 38, 29, 18, 45, 60,
  49, 62, 55, 78, 96, 29, 22, 24, 13, 14, 11, 11, 18, 12, 12, 30, 52, 52,
  44, 28, 28, 20, 56, 40, 31, 50, 40, 46, 42, 29, 19, 36, 25, 22, 17, 19,
  26, 30, 20, 15, 21, 11, 8, 8, 19, 5, 8, 8, 11, 11, 8, 3, 9, 5, 4, 7, 3,
  6, 3, 5, 4, 5, 6
];

// بيانات القرآن
List arabic = [];
List malayalam = [];
List quran = [];

Future readJson() async {
  final String response =
  await rootBundle.loadString("assets/hafs_smart_v8.json");
  final data = json.decode(response);
  arabic = data["quran"];
  malayalam = data["malayalam"];
  return quran = [arabic, malayalam];
}
