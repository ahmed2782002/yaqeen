import '../../data/model/prayer_times_model.dart';

abstract class PrayerTimesState {}

class PrayerTimesInitial extends PrayerTimesState {}

class CountrySelectedState extends PrayerTimesState {}

class PrayerTimesLoading extends PrayerTimesState {}

class PrayerTimesLoaded extends PrayerTimesState {
  final PrayerTimesModel prayerTimesModel;
  final String readableDate;

  PrayerTimesLoaded(this.prayerTimesModel, this.readableDate);
}

class PrayerTimesError extends PrayerTimesState {
  final String message;
  PrayerTimesError(this.message);
}


