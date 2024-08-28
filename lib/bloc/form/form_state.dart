abstract class FormsState {}

class InitialFormsState extends FormsState {}

class LoadingFormsState extends FormsState {}

class InitialSuccessFormsState extends FormsState {}

class SuccessFormsState extends FormsState {}

class FailedFormsState extends FormsState {
  final String error;
  FailedFormsState({required this.error});
}

class CreateFormsState extends FormsState {
  final bool isLoading;
  CreateFormsState({required this.isLoading});
}

class ValidationFailedFormsState extends FormsState {
  final String field;

  ValidationFailedFormsState({required this.field});
}
