

import 'package:equatable/equatable.dart';

import '../models/designation_model.dart';

class HomeState extends Equatable {
  final int selectedCategory;
  final int selectedBottomNav;
  final String searchQuery;
  final List<DestinationModel> destinations;

  const HomeState({
    this.selectedCategory = 0,
    this.selectedBottomNav = 0,
    this.searchQuery = '',
    this.destinations = const [],
  });

  HomeState copyWith({
    int? selectedCategory,
    int? selectedBottomNav,
    String? searchQuery,
    List<DestinationModel>? destinations,
  }) {
    return HomeState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedBottomNav: selectedBottomNav ?? this.selectedBottomNav,
      searchQuery: searchQuery ?? this.searchQuery,
      destinations: destinations ?? this.destinations,
    );
  }

  @override
  List<Object?> get props => [
    selectedCategory,
    selectedBottomNav,
    searchQuery,
    destinations,
  ];
}