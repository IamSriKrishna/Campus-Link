import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/student/student_event.dart';
import 'package:campuslink/bloc/student/student_state.dart';
import 'package:campuslink/controller/student/student_controller.dart';
import 'package:get_storage/get_storage.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentController _studentController;

  StudentBloc(this._studentController) : super(InitialStudentState()) {
    // Handle student search event
    on<StudentSearchEvent>((event, emit) async {
      emit(LoadingStudentState());
      try {
        final studentModel =
            await _studentController.getSearchByName(name: event.name);
        if (studentModel.data.isEmpty) {
          emit(NoResultFoundState(name: event.name));
        } else {
          emit(ReadSearchStudentState(studentModel: studentModel));
        }
      } catch (e) {
        emit(FailedStudentState(error: e.toString()));
      }
    });

    on<UpdateBioEvent>((event, emit) async {
      try {
        emit(LoadingStudentState());
        final prefs = GetStorage();
        final userId = prefs.read("userId");
        if (userId == null) {
          throw Exception('User ID not found');
        }
        final success = await _studentController.updateBio(
            studentId: userId, bio: event.bio);
        await Future.delayed(const Duration(seconds: 5));
        if (success) {
          emit(SuccessStudentState());
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(FailedStudentState(error: e.toString()));
      }
    });
  }
}
