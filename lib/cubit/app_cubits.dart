import 'package:bloc/bloc.dart';
import 'package:my_first_app/cubit/app_cubit_states.dart';
import 'package:my_first_app/models/data_model.dart';
import 'package:my_first_app/services/data_services.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(WelcomeState());
  }
  final DataServices data;
  late final places;
  void getData() async {
    try {
      // showing loading state
      emit(LoadingState());

      // waiting for getting data
      places = await data.getInfo();

      // show loaded state
      emit(LoadedState(places));
    } catch (e) {
      // show error state
    }
  }

  detailPage(DataModel data) {
    emit(DetailState(data));
  }

  goHome() {
    emit(LoadedState(places));
  }
}
