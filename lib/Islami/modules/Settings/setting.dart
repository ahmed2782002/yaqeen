import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Core/Provider/app_provider.dart';
import 'Widget/language_bottom_sheet.dart';
import 'Widget/setting_item.dart';
import 'Widget/theme_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {

    var appProvider = Provider.of<AppProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
      child: Column(
        children: [
          SettingItem(
            settingOptionText: AppLocalizations.of(context)!.language,
            selectedOption:
            appProvider.currentLocale == "en" ? "English" : "العربيه",
            onOptionTapped: () {
              showLanguagesBottomSheet(context);
            },
          ),
          SizedBox(
            height: 40,
          ),
          SettingItem(
              settingOptionText: AppLocalizations.of(context)!.theme_Mode,
              selectedOption: appProvider.isDarkEnabled()
                  ? AppLocalizations.of(context)!.dark
                  : AppLocalizations.of(context)!.light,
              onOptionTapped: () {
                showModeBottomSheet(context);
              }),
        ],
      ),
    );
  }

  void showLanguagesBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottom(),
    );
  }

  void showModeBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}
