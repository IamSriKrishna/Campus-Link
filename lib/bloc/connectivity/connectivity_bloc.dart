
import 'package:connectivity_plus/connectivity_plus.dart';
import 'connectivity_event.dart';
import 'connectivity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();

  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<ConnectivityChanged>(_onConnectivityChanged);
    
    // Monitor connectivity changes
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> connectivityResults) {
      for (var result in connectivityResults) {
        add(ConnectivityChanged(result));
      }
    });
  }

  void _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) {
    if (event.connectivityResult == ConnectivityResult.none) {
      emit(ConnectivityOffline());
    } else {
      emit(ConnectivityOnline());
    }
  }
}