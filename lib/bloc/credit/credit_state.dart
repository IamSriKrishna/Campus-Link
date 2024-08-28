abstract class CreditState {}

class InitialCreditState extends CreditState {}

class LoadingCreditState extends CreditState {}

class SuccessCreditState extends CreditState {}

class FailedCreditState extends CreditState {
  final String error;
  FailedCreditState({required this.error});
}

class UpdateCreditState extends CreditState {
  final bool isLoading;
  UpdateCreditState({required this.isLoading});
}
