import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/bottom/bottom_event.dart';
import 'package:campuslink/bloc/bottom/bottom_state.dart';

class BottomBloc extends Bloc<BottomEvent, BottomState> {
  BottomBloc() : super(BottomState()) {
    on<CurrentIndexEvent>((event, emit) {
      emit(state.copyWith(index: event.index));
    });
  }
}
