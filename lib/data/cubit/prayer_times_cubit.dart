import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'prayer_times_state.dart';
import '../model/prayer_times_model.dart';



class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit() : super(PrayerTimesInitial());

  static PrayerTimesCubit get(context) => BlocProvider.of(context);

  final Map<String, List<String>> arabCountries = {
    'مصر': ['القاهرة', 'الإسكندرية', 'الجيزة', 'أسوان', 'المنصورة'],
    'السعودية': ['مكة', 'المدينة', 'الرياض', 'جدة', 'الدمام'],
    'الإمارات': ['دبي', 'أبوظبي', 'الشارقة', 'العين'],
    'الأردن': ['عمان', 'الزرقاء', 'إربد', 'العقبة'],
    'المغرب': ['الرباط', 'الدار البيضاء', 'مراكش', 'فاس', 'طنجة'],
  };

  String? selectedCountry;
  String? selectedCity;
  PrayerTimesModel? prayerTimesModel;
  String? readableDate;

  void selectCountry(String country) {
    selectedCountry = country;
    selectedCity = null;
    prayerTimesModel = null;
    emit(CountrySelectedState());
  }

  void selectCity(String city) async {
    selectedCity = city;
    emit(PrayerTimesLoading());
    await fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    if (selectedCountry == null || selectedCity == null) return;
    try {
      final now = DateTime.now();
      final formattedDate = DateFormat('dd-MM-yyyy').format(now);
      final url =
          'https://api.aladhan.com/v1/timingsByCity/$formattedDate?city=$selectedCity&country=$selectedCountry&method=5';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        prayerTimesModel = PrayerTimesModel.fromJson(data['data']);
        readableDate = data['data']['date']['readable'];
        emit(PrayerTimesLoaded(prayerTimesModel!, readableDate!));

      } else {
        emit(PrayerTimesError('فشل في جلب مواقيت الصلاة'));
      }
    } catch (e) {
      emit(PrayerTimesError(e.toString()));
    }
  }



}
