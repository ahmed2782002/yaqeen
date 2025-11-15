import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaqeen/Islami/modules/spalsh_screen.dart';
import 'Islami/Core/Provider/app_provider.dart';
import 'Islami/Core/Provider/prefs_helper.dart';
import 'Islami/modules/Hadeth/Hadeth_details_view.dart';
import 'Islami/modules/home/quran/quran_view.dart';
import 'Islami/modules/home_layout.dart';
import 'data/cubit/prayer_times_cubit.dart';
import 'data/cubit/radio_cubit.dart';
import 'data/radio_repository.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences
  PrefsHelper.prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()..init()),
      ],
      child: const MyAppMobile(),
    ),
  );
}

class MyAppMobile extends StatelessWidget {
  const MyAppMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PrayerTimesCubit()),
        BlocProvider(create: (_) => RadioCubit(RadioRepository())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: appProvider.currentTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(appProvider.currentLocale),
      initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (_) => const SplashScreen(),
          HomeLayout.routeName: (_) => const HomeLayout(),
          HadethDetailsView.routeName: (_) => const HadethDetailsView(),
        },
      ),
    );
  }
}
