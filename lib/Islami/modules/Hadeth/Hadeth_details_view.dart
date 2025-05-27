import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Core/Provider/app_provider.dart';

class HadethDetailsView extends StatefulWidget {
  static const String routeName = "Hadeth_Details_View";

  const HadethDetailsView({super.key});

  @override
  State<HadethDetailsView> createState() => _HadethDetailsViewState();
}

class _HadethDetailsViewState extends State<HadethDetailsView> {
  String content = "";
  List<String> allVerses = [];

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as HadethContent;
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
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
          title: Text("إسلامي"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
          margin: EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 120),
          width: mediaQuery.width,
          height: mediaQuery.height,
          decoration: BoxDecoration(
            color: theme.colorScheme.onBackground.withOpacity(0.8),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Text(
                args.title,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
              ),
              Divider(
                color: theme.primaryColor,
                indent: 30,
                endIndent: 30,
                thickness: 1.2,
                height: 10,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      args.content,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.onSecondary, height: 1.8),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HadethContent {
  final String title;
  final String content;

  HadethContent({required this.title, required this.content});
}
