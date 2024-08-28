import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/gate_pass/gate_pass_event.dart';
import 'package:campuslink/bloc/gate_pass/gate_pass_state.dart';

class GatePassBloc extends Bloc<GatePassEvent, GatePassState> {
  GatePassBloc() : super(GatePassState()) {
    on<ReasonEvent>((event, emit) {
      emit(state.copyWith(
        reason: event.reason,
      ));
    });
    on<FromTimeEvent>((event, emit) {
      emit(state.copyWith(
        from: event.time,
      ));
    });
    on<ToTimeEvent>((event, emit) {
      emit(state.copyWith(
        to: event.time,
      ));
    });
    on<ClearEvent>((event, emit) {
      emit(GatePassState()); // Reset to initial state
    });
  }
  void clear() {
    add(ClearEvent());
  }
}
