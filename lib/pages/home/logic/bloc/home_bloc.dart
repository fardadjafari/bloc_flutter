import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_2/constant/enums.dart';
import 'package:flutter_application_2/pages/home/model/home_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(homeEvent: InitialHomeEvent())) {
    on<FetchDataHomeEvent>(_fetchData);
    on<DeleteByIndexEvent>(_DeleteDataByIndex);
    on<SortPersonEvent>(_SortData);
  }

  FutureOr<void> _fetchData(
      FetchDataHomeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(LoadingDataHomeEvent()));

    await Hive.openBox<PersonModel>('dataPersonBox');

    final box = Hive.box<PersonModel>("dataPersonBox");

    emit(state.copyWith(CompletedHomeEvent(box.values.toList())));
  }

  FutureOr<void> _DeleteDataByIndex(
      DeleteByIndexEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(LoadingDataHomeEvent()));

    final box = Hive.box<PersonModel>("dataPersonBox");

    await box.deleteAt(event.index);

    emit(state.copyWith(CompletedHomeEvent(box.values.toList())));
  }

  FutureOr<void> _SortData(SortPersonEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(LoadingDataHomeEvent()));

    final box = Hive.box<PersonModel>("dataPersonBox");

    switch (event.sort) {
      case Sort.sortByLastName:
        {
          final sortListed = box.values.toList()
            ..sort(
              (a, b) => a.lastname.compareTo(b.lastname),
            );

          emit(state.copyWith(CompletedHomeEvent(sortListed)));
        }
        break;
      case Sort.sortByName:
        {
          final sortListed = box.values.toList()
            ..sort(
              (a, b) => a.lastname.compareTo(b.firstname),
            );

          emit(state.copyWith(CompletedHomeEvent(sortListed)));
        }
        break;
      default:
        {
          emit(state.copyWith(CompletedHomeEvent(box.values.toList())));
        }
    }
  }
}
