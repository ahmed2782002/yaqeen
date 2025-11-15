class PrayerTimesModel {
  final Map<String, String> timings;

  PrayerTimesModel({required this.timings});

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimesModel(
      timings: {
        'الفجر': json['timings']['Fajr'],
        'الظهر': json['timings']['Dhuhr'],
        'العصر': json['timings']['Asr'],
        'المغرب': json['timings']['Maghrib'],
        'العشاء': json['timings']['Isha'],
      },
    );
  }
}
