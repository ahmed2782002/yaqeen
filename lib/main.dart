import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Islami/Core/Provider/app_provider.dart';
import 'Islami/Core/Provider/prefs_helper.dart';
import 'Islami/Core/application_theme.dart';
import 'Islami/modules/Hadeth/Hadeth_details_view.dart';
import 'Islami/modules/Quran/quran_view.dart';
import 'Islami/modules/home_layout.dart';
import 'Islami/modules/spalsh_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PrefsHelper.prefs = await SharedPreferences.getInstance();
  runApp(ChangeNotifierProvider(
      create: (buildContext) => AppProvider()..init(), child: MyappMobile()));
}

class MyappMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ApplicationTheme.lightTheme,
      darkTheme: ApplicationTheme.darkTheme,
      // Through it I can control the system whether light or dark by provider
      themeMode: appProvider.currentTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: SplashScreen.routeName,
      locale: Locale(appProvider.currentLocale),
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        HomeLayout.routeName: (_) => HomeLayout(),
        QuranView.routeName: (_) => QuranView(),
        HadethDetailsView.routeName: (_) => HadethDetailsView(),
      },
    );
  }
}




