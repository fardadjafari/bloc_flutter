import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_2/constant/hive.dart';
import 'package:flutter_application_2/pages/home/model/home_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'add_user_event.dart';
part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUSerState> {
  AddUserBloc() : super(AddUSerState(addUserEvent: InitialAddEvent())) {
    on<AddRecordEvent>(_addUserTask);
  }

  FutureOr<void> _addUserTask(
      AddRecordEvent event, Emitter<AddUSerState> emit) async {
    emit(state.copyWith(LoadingDataAddEvent()));

    final box = Hive.box<PersonModel>(HiveTable.boxPerson);
    final model = PersonModel(
        id: const Uuid().v1(),
        firstname: event.firstname,
        lastname: event.lastname,
        sex: event.sex);

    box.add(model);

    emit(state.copyWith(CompletedAddEvent(box.values.toList())));
  }
}
