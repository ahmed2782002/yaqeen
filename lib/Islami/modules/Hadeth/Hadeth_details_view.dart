import 'package:flutter/material.dart';

class HadethDetailsView extends StatefulWidget {
  static const String routeName = "Hadeth_Details_View";

  const HadethDetailsView({super.key});

  @override
  State<HadethDetailsView> createState() => _HadethDetailsViewState();
}

class _HadethDetailsViewState extends State<HadethDetailsView> {

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as HadethContent;
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xff202020),
      appBar: AppBar(
        backgroundColor: const Color(0xff202020),
        iconTheme: const IconThemeData(
          color: Colors.white70,
        ),
      ),
      body: Column(
        children: [
          // ✅ الجزء اللي فيه المحتوى فقط
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Column(
                children: [
                  Text(
                    args.title,
                    style:const TextStyle(
                      color: const Color(0xffE2BE7F),
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                const  Divider(
                    color: Colors.white70,
                    indent: 30,
                    endIndent: 30,
                    thickness: 1.2,
                    height: 10,
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        args.content,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xffE2BE7F),
                            height: 1.8
                            ,fontSize: 20
                        )
                         ,
                        ),
                      ),
                    ),

                ],
              ),
            ),
          ),

          // ✅ الصورة برا الـ Padding = ملهاش أي مسافة
          Image.asset(
            "assets/images/gggg.png",
            width: double.infinity,
            fit: BoxFit.cover,
            height: 120, // عدل المقاس براحتك
          ),
        ],
      ),
    );
  }
}

class HadethContent {
  final String title;
  final String content;

  HadethContent({required this.title, required this.content});
}
