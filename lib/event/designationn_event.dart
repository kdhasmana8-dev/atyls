import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {}

class CategoryChanged extends HomeEvent {
  final int index;

  const CategoryChanged(this.index);

  @override
  List<Object?> get props => [index];
}

class SearchChanged extends HomeEvent {
  final String query;

  const SearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class BottomNavigationChanged extends HomeEvent {
  final int index;

  const BottomNavigationChanged(this.index);

  @override
  List<Object?> get props => [index];
}