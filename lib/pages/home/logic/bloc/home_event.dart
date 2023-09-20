part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class InitialHomeEvent extends HomeEvent {}

class LoadingDataHomeEvent extends HomeEvent {}

class FetchDataHomeEvent extends HomeEvent {}

class CompletedHomeEvent extends HomeEvent {
  final List<PersonModel> personModel;

  CompletedHomeEvent(this.personModel);
}

class DeleteByIndexEvent extends HomeEvent {
  final int index;

  DeleteByIndexEvent({required this.index});
}

class SortPersonEvent extends HomeEvent {
  final Sort sort;

  SortPersonEvent({required this.sort});
}
