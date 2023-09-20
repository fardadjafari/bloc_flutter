part of 'add_user_bloc.dart';

class AddUSerState {
  final AddUserEvent addUserEvent;

  AddUSerState({required this.addUserEvent});

  AddUSerState copyWith(AddUserEvent? addUserEvent) {
    return AddUSerState(addUserEvent: addUserEvent ?? this.addUserEvent);
  }
}
