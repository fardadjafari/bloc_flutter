part of 'edit_user_bloc.dart';

@immutable
abstract class EditUserEvent {}

class InitialEditEvent extends EditUserEvent {}

class LoadingDataEditEvent extends EditUserEvent {}

class FetchDataEditEvent extends EditUserEvent {}

class CompletedEditEvent extends EditUserEvent {
  final List<PersonModel> personModel;

  CompletedEditEvent(this.personModel);
}

class EditRecordEvent extends EditUserEvent {
  final String id;
  final String firstname;
  final String lastname;
  final String sex;
  final int index;

  EditRecordEvent(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.sex,
      required this.index});
}

class DeleteAllUser extends EditUserEvent {}
