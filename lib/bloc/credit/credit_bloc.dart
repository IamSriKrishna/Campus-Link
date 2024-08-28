import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/credit/credit_event.dart';
import 'package:campuslink/bloc/credit/credit_state.dart';
import 'package:campuslink/controller/credit/credit_controller.dart';
import 'package:get_storage/get_storage.dart';

class CreditBloc extends Bloc<CreditEvent, CreditState> {
  final CreditController _creditController;
  CreditBloc(this._creditController) : super(InitialCreditState()) {
    on<UpdateCreditEvent>((event, emit) async {
      final box = GetStorage();
      final userId = box.read("userId");

      if (userId == null) {
        throw Exception('User ID not found');
      }

      emit(UpdateCreditState(isLoading: false));
      try {
        emit(LoadingCreditState());
        final success = await _creditController.updateCredit(
            id: userId, credit: event.credit);
        if (success) {
          emit(SuccessCreditState());
        } else {
          emit(UpdateCreditState(isLoading: false));
        }
      } catch (e) {
        emit(UpdateCreditState(isLoading: false));
        emit(FailedCreditState(error: e.toString()));
      }
    });
  }
}
