import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final ConnectivityResult connectivityResult;

  ConnectivityChanged(this.connectivityResult);
}