part of 'add_user_bloc.dart';

@immutable
abstract class AddUserEvent {}

class InitialAddEvent extends AddUserEvent {}

class LoadingDataAddEvent extends AddUserEvent {}

class FetchDataAddEvent extends AddUserEvent {}

class CompletedAddEvent extends AddUserEvent {
  final List<PersonModel> personModel;

  CompletedAddEvent(this.personModel);
}

class AddRecordEvent extends AddUserEvent {
  final String firstname;
  final String lastname;
  final String sex;

  AddRecordEvent(
      {required this.firstname, required this.lastname, required this.sex});
}
