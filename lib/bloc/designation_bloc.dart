import 'package:flutter_bloc/flutter_bloc.dart';
import '../event/designationn_event.dart';
import '../models/designation_model.dart';
import '../state/designation_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<DestinationModel> _allDestinations = const [
    DestinationModel(
      country: 'THAILAND',
      image: 'assets/images/image.png',
      flag: '🇹🇭',
      validDays: '90 DAYS',
    ),
    DestinationModel(
      country: 'UNITED ARAB\nEMIRATES',
      image: 'assets/images/explore.png',
      flag: '🇦🇪',
      validDays: '60 DAYS',
    ),
    DestinationModel(
      country: 'FRANCE',
      image: 'assets/images/explore.png',
      flag: '🇫🇷',
      validDays: '90 DAYS',
    ),
    DestinationModel(
      country: 'ITALY',
      image: 'assets/images/image.png',
      flag: '🇮🇹',
      validDays: '60 DAYS',
    ),
  ];

  HomeBloc() : super(const HomeState()) {
    on<HomeStarted>(_onHomeStarted);
    on<CategoryChanged>(_onCategoryChanged);
    on<SearchChanged>(_onSearchChanged);
    on<BottomNavigationChanged>(_onBottomNavigationChanged);
  }

  void _onHomeStarted(
      HomeStarted event,
      Emitter<HomeState> emit,
      ) {
    emit(
      state.copyWith(
        destinations: _allDestinations,
      ),
    );
  }

  void _onCategoryChanged(
      CategoryChanged event,
      Emitter<HomeState> emit,
      ) {
    emit(
      state.copyWith(
        selectedCategory: event.index,
      ),
    );
  }

  void _onSearchChanged(
      SearchChanged event,
      Emitter<HomeState> emit,
      ) {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(
        state.copyWith(
          searchQuery: '',
          destinations: _allDestinations,
        ),
      );
      return;
    }

    final filtered = _allDestinations.where((destination) {
      return destination.country
          .toLowerCase()
          .contains(query);
    }).toList();

    emit(
      state.copyWith(
        searchQuery: event.query,
        destinations: filtered,
      ),
    );
  }

  void _onBottomNavigationChanged(
      BottomNavigationChanged event,
      Emitter<HomeState> emit,
      ) {
    emit(
      state.copyWith(
        selectedBottomNav: event.index,
      ),
    );
  }
}