import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_2/constant/hive.dart';
import 'package:flutter_application_2/pages/home/model/home_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  EditUserBloc() : super(EditUserState(editUserEvent: InitialEditEvent())) {
    on<EditRecordEvent>(_editUser);
    on<DeleteAllUser>(_DeleteAllUser);
  }

  FutureOr<void> _editUser(
      EditRecordEvent event, Emitter<EditUserState> emit) async {
    emit(state.copyWith(LoadingDataEditEvent()));

    final box = Hive.box<PersonModel>(HiveTable.boxPerson);
    final model = PersonModel(
        id: event.id,
        firstname: event.firstname,
        lastname: event.lastname,
        sex: event.sex);

    box.putAt(event.index, model);

    emit(state.copyWith(CompletedEditEvent(box.values.toList())));
  }

  FutureOr<void> _DeleteAllUser(
      DeleteAllUser event, Emitter<EditUserState> emit) async {
    emit(state.copyWith(LoadingDataEditEvent()));
    final box = Hive.box<PersonModel>(HiveTable.boxPerson);
    await box.clear();

    emit(state.copyWith(CompletedEditEvent(box.values.toList())));
  }
}
