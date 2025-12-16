import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/radio_repository.dart';

import 'radio_state.dart';

class RadioCubit extends Cubit<RadioState> {
  final RadioRepository radioRepository;

  RadioCubit(this.radioRepository) : super(RadioInitial());

  Future<void> getRadios() async {
    emit(RadioLoading());
    try {
      final radios = await radioRepository.getRadios();
      emit(RadioSuccess(radios));
    } catch (e) {
      emit(RadioError("An error occurred while loading the radio stations:$e"));
    }
  }
}
