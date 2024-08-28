import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/form/form_event.dart';
import 'package:campuslink/bloc/form/form_state.dart';
import 'package:campuslink/controller/form/form_controller.dart';

class FormBloc extends Bloc<FormEvent, FormsState> {
  final FormController _formController;

  FormBloc(this._formController) : super(InitialFormsState()) {
    on<CreateFormEvent>((event, emit) async {
      if (event.name.isEmpty) {
        emit(ValidationFailedFormsState(field: 'Name'));
        return;
      }
      if (event.department.isEmpty) {
        emit(ValidationFailedFormsState(field: 'Department'));
        return;
      }
      if (event.year.isEmpty) {
        emit(ValidationFailedFormsState(field: 'Year'));
        return;
      }
      if (event.reason.isEmpty) {
        emit(ValidationFailedFormsState(field: 'Reason'));
        return;
      }
      if (event.from.isEmpty) {
        emit(ValidationFailedFormsState(field: 'From'));
        return;
      }
      if (event.to.isEmpty) {
        emit(ValidationFailedFormsState(field: 'To'));
        return;
      }
      emit(CreateFormsState(isLoading: true));
      try {
        emit(LoadingFormsState());
        final success = await _formController.createForm(
            name: event.name,
            department: event.department,
            year: event.year,
            spent: event.spent,
            studentClass: event.studentClass,
            formtype: event.formtype,
            reason: event.reason,
            from: event.from,
            to: event.to);

        await Future.delayed(const Duration(seconds: 5));

        if (success) {
          emit(SuccessFormsState());
        }
        emit(CreateFormsState(isLoading: false));
      } catch (e) {
        emit(FailedFormsState(error: e.toString()));
      }
    });
  }
}
