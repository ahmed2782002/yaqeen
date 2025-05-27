import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../Core/Provider/app_provider.dart';
import 'constant.dart';

class QuranDetailsView extends StatefulWidget {
  final sura;
  final arabic;
  final suraName;
  int ayah;

  QuranDetailsView(
      {Key? key, this.sura, this.arabic, this.suraName, required this.ayah})
      : super(key: key);

  @override
  _QuranDetailsViewState createState() => _QuranDetailsViewState();
}

class _QuranDetailsViewState extends State<QuranDetailsView> {
  bool view = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => jumbToAyah());
    super.initState();
  }

  jumbToAyah() {
    if (fabIsClicked) {
      itemScrollController.scrollTo(
          index: widget.ayah,
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOutCubic);
    }
    fabIsClicked = false;
  }

  Row verseBuilder(int index, previousVerses) {
    return Row(
      children: [
        Expanded(
          child: Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
color: Color(0xffffffff).withOpacity(.9)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.arabic[index + previousVerses]['aya_text'],
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: arabicFontSize,
                    fontFamily: arabicFont,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SafeArea SingleSuraBuilder(LenghtOfSura) {
    String fullSura = '';
    int previousVerses = 0;
    if (widget.sura + 1 != 1) {
      for (int i = widget.sura - 1; i >= 0; i--) {
        previousVerses = previousVerses + noOfVerses[i];
      }
    }

    if (!view)
      for (int i = 0; i < LenghtOfSura; i++) {
        fullSura += (widget.arabic[i + previousVerses]['aya_text']);
      }

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 50),
        child: view
            ? ScrollablePositionedList.builder(
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                (index != 0) || (widget.sura == 0) || (widget.sura == 8)
                    ? const Text('')
                    :  RetunBasmala(color: Theme.of(context).colorScheme.onPrimary,),
                Container(
                  child: PopupMenuButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: verseBuilder(index, previousVerses),
                      ),
                      itemBuilder: (context) => []),
                ),
              ],
            );
          },
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          itemCount: LenghtOfSura,
        )
            : ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.sura + 1 != 1 && widget.sura + 1 != 9
                          ?  RetunBasmala(color: Theme.of(context).colorScheme.onSurface,)
                          : const Text(''),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          fullSura,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: mushafFontSize,
                            fontFamily: arabicFont,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int LengthOfSura = noOfVerses[widget.sura];
    var appProvider = Provider.of<AppProvider>(context);

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
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: EdgeInsets.only(top: 20),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                widget.suraName,
                style:  TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                  fontFamily: 'quran',
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Tooltip(
                message: 'Mushaf Mode',
                child: IconButton(
                  icon:  Icon(Icons.chrome_reader_mode, color:Theme.of(context).colorScheme.onSurface),
                  onPressed: () {
                    setState(() {
                      view = !view;
                    });
                  },
                ),
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
          margin:
          const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 120),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
            borderRadius: BorderRadius.circular(25),
          ),
          child: SingleSuraBuilder(LengthOfSura),
        )
      ),
    );
  }
}

class RetunBasmala extends StatelessWidget {
Color? color;

RetunBasmala({required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         Padding(
           padding: EdgeInsets.only(bottom: 50),
           child: Center(

            child: Text(
              'بسم الله الرحمن الرحيم',
              style: TextStyle(fontFamily: 'me_quran', fontSize: 30 ,
              color:color
              ),
              textDirection: TextDirection.rtl,
            ),
                   ),
         ),
      ],
    );
  }
}
