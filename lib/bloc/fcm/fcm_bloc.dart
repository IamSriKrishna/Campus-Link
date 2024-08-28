import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/fcm/fcm_event.dart';
import 'package:campuslink/bloc/fcm/fcm_state.dart';
import 'package:campuslink/controller/fcm/fcm_controller.dart';
import 'package:get_storage/get_storage.dart';

class FcmBloc extends Bloc<FcmEvent, FcmState> {
  final FcmController _fcmController;
  FcmBloc(this._fcmController) : super(InitialFcmState()) {
    on<UpdateFcmTokenEvent>((event, emit) async {
      emit(UpdateFcmTokenState(isLoading: true));
      try {
        emit(LoadingFcmState());
        final box = GetStorage();
        final userId = box.read("userId");
        if (userId == null) {
          throw Exception('User ID not found');
        }
        final success = await _fcmController.updateFcmToken(
            id: userId, fcmtoken: event.fcmtoken);
        if (success) {
          emit(SuccessFcmState());
        } else {
          emit(UpdateFcmTokenState(isLoading: false));
        }
      } catch (e) {
        emit(UpdateFcmTokenState(isLoading: false));
        emit(FailedFcmState(error: e.toString()));
      }
    });

    on<SendFcmEvent>((event, emit) async {
      try {
        emit(LoadingFcmState());
        final success = await _fcmController.sendNotification(
            title: event.title, body: event.body, token: event.token);
        if (success) {
          emit(SuccessFcmState());
        }
      } catch (e) {
        emit(FailedFcmState(error: e.toString()));
      }
    });
  }
}
