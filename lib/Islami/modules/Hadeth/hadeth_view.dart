import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Hadeth_details_view.dart';

class HadethView extends StatefulWidget {
  const HadethView({super.key});

  @override
  State<HadethView> createState() => _HadethViewState();
}

class _HadethViewState extends State<HadethView> {
  List<HadethContent> allHadethContent = [];

  @override
  Widget build(BuildContext context) {
    if (allHadethContent.isEmpty) readFile();
    var theme = Theme.of(context);
    return Column(
      children: [
        Image.asset("assets/images/hadeth_header.png", width: 312, height: 219),
        Divider(
          thickness: 1.5,
          indent: 10,
          endIndent: 10,
          height: 10,
        ),
        Text(
          "الأحاديث",
          style: theme.textTheme.bodyMedium,
        ),
        Divider(
          thickness: 1.5,
          indent: 10,
          endIndent: 10,
          height: 10,
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, HadethDetailsView.routeName,
                    arguments: HadethContent(
                        title: allHadethContent[index].title,
                        content: allHadethContent[index].content));
              },
              child: Text(
                allHadethContent[index].title,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            separatorBuilder: (context, index) => Divider(
              thickness: 1.2,
              indent: 80,
              endIndent: 80,
              height: 10,
            ),
            itemCount: allHadethContent.length,
          ),
        )
      ],
    );
  }

  readFile() async {
    String text = await rootBundle.loadString("assets/files/ahadeth.txt");
    List<String> allHadeth = text.split("#");
    for (int i = 0; i < allHadeth.length; i++) {
      String singleHadeth = allHadeth[i].trim();
      int indexOfFirstLine = singleHadeth.indexOf("\n"); //
      String title = singleHadeth.substring(
          0, indexOfFirstLine); // cut hadeth name 1 to 50
      String content = singleHadeth.substring(indexOfFirstLine + 1);
      HadethContent hadethContent =
      HadethContent(title: title, content: content);
      allHadethContent.add(hadethContent);
      setState(() {});
    }
  }
}
