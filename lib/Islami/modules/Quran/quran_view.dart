import 'package:flutter/material.dart';
import 'package:yaqeen/Islami/modules/Quran/quran_details_view.dart';


import 'arabic_sura_number.dart';
import 'constant.dart';

class QuranView extends StatefulWidget {
  static const String routeName = "Quran_view";
  const QuranView({Key? key}) : super(key: key);

  @override
  State<QuranView> createState() => _QuranViewState();
}

class _QuranViewState extends State<QuranView> {

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: readJson(),
        builder: (
            BuildContext context,
            AsyncSnapshot snapshot,
            ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return indexCreator(snapshot.data, context);
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }

  Widget indexCreator(quran, context) {
    return Column(
      children: [
        Image.asset("assets/images/icon_quran.png", width: 205, height: 227),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 30),
            child: ListView.builder(
              itemCount: 114,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Container(
                      color: Colors.transparent,
                      child: TextButton(
                        child: Row(
                          children: [
                           ArabicSuraNumber(i: i),
                            const SizedBox(
                              width: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              ),
                            ),
                             Expanded(child: SizedBox()),
                            Text(
                              arabicName[i]['name'],
                              style:  TextStyle(
                                fontSize: 30,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontFamily: 'quran',
                                shadows: [
                                  Shadow(
                                    offset: Offset(.5, .5),
                                    blurRadius: 1.0,
                                    color: Color.fromARGB(255, 130, 130, 130),
                                  )
                                ],
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                        onPressed: () {
                          fabIsClicked = false;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuranDetailsView(
                                arabic: quran[0],
                                sura: i,
                                suraName: arabicName[i]['name'],
                                ayah: 0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                     Divider(color: Theme.of(context).colorScheme.onPrimary),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
