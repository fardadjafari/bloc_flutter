part of 'edit_user_bloc.dart';

class EditUserState {
  final EditUserEvent editUserEvent;

  EditUserState({required this.editUserEvent});

  EditUserState copyWith(EditUserEvent? editUserEvent) {
    return EditUserState(editUserEvent: editUserEvent ?? this.editUserEvent);
  }
}
