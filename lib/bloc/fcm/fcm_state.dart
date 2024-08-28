abstract class FcmState {}

class InitialFcmState extends FcmState {}

class LoadingFcmState extends FcmState {}

class SuccessFcmState extends FcmState {}

class FailedFcmState extends FcmState {
  final String error;
  FailedFcmState({required this.error});
}

class UpdateFcmTokenState extends FcmState {
  final bool isLoading;
  UpdateFcmTokenState({required this.isLoading});
}
