import 'package:flutter/material.dart';
import '../../../../../data/cubit/prayer_times_cubit.dart';

class CountryCitySheet extends StatefulWidget {
  const CountryCitySheet({super.key});

  @override
  State<CountryCitySheet> createState() => _CountryCitySheetState();
}

class _CountryCitySheetState extends State<CountryCitySheet> {
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    var cubit = PrayerTimesCubit.get(context);

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        color: const Color(0XFF202020),
        padding: const EdgeInsets.all(16),
        height: 400,
        child: selectedCountry == null
            ? Column(
          children: [
            const Text(
              "اختر الدولة",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: cubit.arabCountries.keys.map((country) {
                  return ListTile(
                    title: Text(
                      country,
                      style: const TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      setState(() => selectedCountry = country);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        )
            : Column(
          children: [
            Text(
              "مدن: $selectedCountry",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children:
                cubit.arabCountries[selectedCountry]!.map((city) {
                  return ListTile(
                    title: Text(
                      city,
                      style: const TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      cubit.selectCountry(selectedCountry!);
                      cubit.selectCity(city);
                      Navigator.pop(context);
                      cubit.fetchPrayerTimes();
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
