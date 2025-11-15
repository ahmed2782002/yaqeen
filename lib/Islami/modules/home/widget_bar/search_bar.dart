import 'package:flutter/material.dart';
import 'package:yaqeen/Islami/modules/home/widget_bar/select_country.dart';

import '../quran/constant_and_view/arabic_sura_number.dart';
import '../quran/constant_and_view/constant.dart';
import '../quran/quran__details/quran_details_view.dart';
class SearchBarWidget extends StatelessWidget {
  SearchBarWidget({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 12),
          child: SizedBox(
            width: size.width * .77,
            height: 44,
            child: TextField(
              controller: controller,
              textDirection: TextDirection.rtl,
              style: const TextStyle(color: Colors.white),
              onSubmitted: (value) {
                if (value.trim().isEmpty) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuranSearchPage(
                      searchWord: value,
                      quranData: quran,
                    ),
                  ),
                );
              },
              decoration: InputDecoration(
                hintText: "Sura Name",
                hintStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: const Color(0xFF202020).withOpacity(.7),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2BE7F), width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2BE7F), width: 1.4),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ),

        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: const Color(0xFF1E3A5F),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => CountryCitySheet(),
            );
          },
          child: Image.asset(
            "assets/images/countries.png",
            width: 32,
            height: 32,
          ),
        ),
      ],
    );
  }
}


class QuranSearchPage extends StatefulWidget {
  final String searchWord;
  final dynamic quranData;

  const QuranSearchPage({
    super.key,
    required this.searchWord,
    required this.quranData,
  });

  @override
  State<QuranSearchPage> createState() => _QuranSearchPageState();
}

class _QuranSearchPageState extends State<QuranSearchPage> {
  List<Map> results = [];

  @override
  void initState() {
    super.initState();
    search();
  }

  void search() {
    String query = removeTashkeel(widget.searchWord);

    results = arabicName.where((sura) {
      String suraName = removeTashkeel(sura["name"]);
      return suraName.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        title: Text("نتائج البحث", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF121212),
      ),

      body: results.isEmpty
          ? Center(
        child: Text(
          "لا توجد نتائج",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      )
          : ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          var sura = results[index];
          int suraIndex = int.parse(sura["surah"]) - 1;

          return Column(
            children: [
              TextButton(
                onPressed: () {
                  fabIsClicked = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuranDetailsView(
                        arabic: widget.quranData[0],
                        sura: suraIndex,
                        suraName: sura["name"],
                        ayah: 0,
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ArabicSuraNumber(i: suraIndex),

                    Expanded(
                      child: Center(
                        child: Text(
                          sura["name"],
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontFamily: 'quran',
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        "${noOfVerses[suraIndex]} آية",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
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
    );
  }
}


