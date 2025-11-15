import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaqeen/Islami/modules/home/prayer_time/prayer_box.dart';
import '../../../../data/cubit/prayer_times_cubit.dart';
import '../../../../data/cubit/prayer_times_state.dart';


class PrayerTimeWidget extends StatelessWidget {
  const PrayerTimeWidget({super.key});

  Map<String, String> formatTo12Hour(String time24) {
    final parts = time24.split(":");
    int hour = int.parse(parts[0]);
    final minute = parts[1];
    String suffix = "AM";
    if (hour >= 12) {
      suffix = "PM";
      if (hour > 12) hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }
    return {"time": "$hour:$minute", "suffix": suffix};
  }

  int getNextPrayerIndex(List<Map<String, String>> prayers) {
    final now = DateTime.now();
    for (int i = 0; i < prayers.length; i++) {
      String time = prayers[i]["time"]!;
      final parts = time.split(":");
      final prayerTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
      if (prayerTime.isAfter(now)) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        var cubit = PrayerTimesCubit.get(context);

        if (state is PrayerTimesLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        if (cubit.prayerTimesModel == null) {
          return const Text(
            "الرجاء اختيار الدولة والمدينة",
            style: TextStyle(color: Colors.white, fontSize: 18),
          );
        }

        final prayers = cubit.prayerTimesModel!.timings.entries.map((e) {
          return {"name": e.key, "time": e.value};
        }).toList();

        int nextPrayerIndex = getNextPrayerIndex(prayers);

        return Column(
          children: [
            Text(
              "${cubit.selectedCountry!} - ${cubit.selectedCity!}",
              style: const TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              cubit.readableDate ?? "",
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 135,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: prayers.length,
                itemBuilder: (context, index) {
                  final formatted = formatTo12Hour(prayers[index]["time"]!);
                  return PrayerBox(
                    name: prayers[index]["name"]!,
                    time: formatted["time"]!,
                    suffix: formatted["suffix"]!,
                    isActive: index == nextPrayerIndex,
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "⏱️ الصلاة القادمة: ${prayers[nextPrayerIndex]["name"]}",
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),

          ],
        );
      },
    );
  }
}

