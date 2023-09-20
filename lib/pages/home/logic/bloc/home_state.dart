part of 'home_bloc.dart';

class HomeState {
  final HomeEvent homeEvent;

  HomeState({required this.homeEvent});

  HomeState copyWith(HomeEvent? homeEvent) {
    return HomeState(homeEvent: homeEvent ?? this.homeEvent);
  }
}
