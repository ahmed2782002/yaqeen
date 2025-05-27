import 'package:flutter/material.dart';

typedef settingsOptionClicked = void Function();

class SettingItem extends StatelessWidget {
  final String settingOptionText, selectedOption;
  final settingsOptionClicked onOptionTapped;

  SettingItem(
      {super.key,
      required this.settingOptionText,
      required this.selectedOption,
      required this.onOptionTapped});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          settingOptionText,
          textAlign: TextAlign.start,
          style: theme.textTheme.bodyLarge,
        ),
        GestureDetector(
          onTap: onOptionTapped,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: mediaQuery.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: theme.colorScheme.onSecondary,
                  width: 1.2,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedOption,
                  style: theme.textTheme.bodyMedium,
                ),
                Icon(
                  Icons.arrow_drop_down_sharp,
                  color: theme.colorScheme.onSecondary,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
