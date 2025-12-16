import '../../../../../data/model/radiosModel.dart';

abstract class RadioState {}

class RadioInitial extends RadioState {}

class RadioLoading extends RadioState {}

class RadioSuccess extends RadioState {
  final List<Radios> radios;
  RadioSuccess(this.radios);
}

class RadioError extends RadioState {
  final String message;
  RadioError(this.message);
}
