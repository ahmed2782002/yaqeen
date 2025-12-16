import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/prayer_time_repo.dart';
import 'prayer_times_state.dart';
import '../../data/model/prayer_times_model.dart';

class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  PrayerTimesCubit(this.repo) : super(PrayerTimesInitial());

  final PrayerRepository repo;

  static PrayerTimesCubit get(context) =>
      BlocProvider.of<PrayerTimesCubit>(context);

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
    await fetchPrayerTimes();
  }

  Future<void> fetchPrayerTimes() async {
    if (selectedCountry == null || selectedCity == null) return;

    emit(PrayerTimesLoading());

    try {
      final result = await repo.getPrayerTimes(
        country: selectedCountry!,
        city: selectedCity!,
      );

      prayerTimesModel = result.$1;
      readableDate = result.$2;

      emit(PrayerTimesLoaded(prayerTimesModel!, readableDate!));
    } catch (e) {
      emit(PrayerTimesError(e.toString()));
    }
  }
}
