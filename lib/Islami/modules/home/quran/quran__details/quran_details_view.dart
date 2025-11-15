import 'package:flutter/material.dart';
import 'package:yaqeen/Islami/modules/home/quran/quran__details/sura_content.dart';
import '../constant_and_view/constant.dart';

class QuranDetailsView extends StatefulWidget {
  final int sura;
  final List arabic;
  final String suraName;
  final int ayah;

  const QuranDetailsView({
    Key? key,
    required this.sura,
    required this.arabic,
    required this.suraName,
    required this.ayah,
  }) : super(key: key);

  @override
  _QuranDetailsViewState createState() => _QuranDetailsViewState();
}

class _QuranDetailsViewState extends State<QuranDetailsView> {
  bool mushafView = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => jumpToAyah());
  }

  void jumpToAyah() {
    if (fabIsClicked) {
      itemScrollController.scrollTo(
        index: widget.ayah - 1,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOutCubic,
      );
    }
    fabIsClicked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202020),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, ), // تحريك كل المحتوى لأسفل
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xffE2BE7F)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              title: Text(
                widget.suraName,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'quran',
                  color: Color(0xffE2BE7F),
                ),
                textAlign: TextAlign.center,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 20 , right: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        mushafView = !mushafView; // قلب الحالة
                      });
                    },
                    child: Image.asset(
                      mushafView
                          ? 'assets/images/arrow_w.png'   // القفل المفتوح
                          : 'assets/images/arrow.png' ,  // القفل المفتوح
                                  // القفل المغلق
                      width: 30,
                      height: 30,

                    ),
                  ),


                ),
              ],
              centerTitle: true,
              elevation: 0,
            ),
            Expanded(
              child: SuraContent(
                suraIndex: widget.sura,
                arabic: widget.arabic,
                mushafView: mushafView,
              ),
            ),
            Image.asset(
              "assets/images/gggg.png",
              width: double.infinity,
              fit: BoxFit.cover,
              height: 120, // عدل المقاس براحتك
            ),
          ],
        ),
      ),
    );
  }
}
