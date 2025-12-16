import 'package:intl/intl.dart';

import '../model/prayer_times_model.dart';
import '../network/api_manager.dart';

class PrayerRepository {
  Future<(PrayerTimesModel, dynamic)> getPrayerTimes({
    required String country,
    required String city,
  }) async {
    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy').format(now);

    final data = await ApiManager.get(
      endpoint: '/timingsByCity/$formattedDate',
      query: {
        'city': city,
        'country': country,
        'method': '5',
      },
    );

    final model = PrayerTimesModel.fromJson(data['data']);
    final readableDate = data['data']['date']['readable'];

    return (model, readableDate);
  }
}
