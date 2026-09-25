import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/designation_bloc.dart';
import '../event/designationn_event.dart';
import '../state/designation_state.dart';
import '../widgets/designation_bottom.dart';
import '../widgets/designation_card.dart';
import '../widgets/top_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(HomeStarted()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          // Guaranteed minimum 10 cards to render in the grid
          final int cardCount = (state.destinations.length < 10)
              ? 10
              : state.destinations.length;

          return Stack(
            children: [
              // ===============================
              // BACKGROUND IMAGE (Fixed Background)
              // ===============================
              Positioned.fill(
                child: Image.asset(
                  'assets/images/home_background.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: const Color(0xFFAED0DF),
                    );
                  },
                ),
              ),

              // GRADIENT OVERLAY
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFB1D3E2).withOpacity(0.85),
                        Colors.transparent,
                        Colors.white.withOpacity(0.1),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
              ),

              // ===============================
              // SINGLE SCROLLABLE VIEW (Poori screen scroll hogi)
              // ===============================
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      // TOURIST BUTTON
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 8, right: 16),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Text(
                                  'Tourist',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // TOP CATEGORIES
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TopCategory(
                            image: 'assets/images/explore.png',
                            title: 'Explore',
                            selected: state.selectedCategory == 0,
                            onTap: () {
                              context
                                  .read<HomeBloc>()
                                  .add(const CategoryChanged(0));
                            },
                          ),
                          const SizedBox(width: 16),
                          TopCategory(
                            image: 'assets/images/image.png',
                            title: 'Events',
                            selected: state.selectedCategory == 1,
                            onTap: () {
                              context
                                  .read<HomeBloc>()
                                  .add(const CategoryChanged(1));
                            },
                          ),
                          const SizedBox(width: 16),
                          TopCategory(
                            image: 'assets/images/image.png',
                            title: 'Activities',
                            selected: state.selectedCategory == 2,
                            onTap: () {
                              context
                                  .read<HomeBloc>()
                                  .add(const CategoryChanged(2));
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // TITLE
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'where do you plan\nto travel next',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'serif',
                            fontSize: 26,
                            height: 1.15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // SEARCH + FILTER ROW
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(28),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                                child: TextField(
                                  onChanged: (value) {
                                    context
                                        .read<HomeBloc>()
                                        .add(SearchChanged(value));
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      size: 22,
                                      color: Color(0xFF68717A),
                                    ),
                                    hintText: 'Search Country',
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF68717A),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // FILTER BUTTON
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFE0E0E0),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.tune_rounded,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // LOCATION PIN BADGE
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.6),
                            width: 1,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Barreirinhas, Brasil',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // ===============================
                      // WHITE CARDS CONTAINER (Non-Scrollable Grid inside Scrollable Body)
                      // ===============================
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(28),
                          ),
                        ),
                        child: GridView.builder(
                          shrinkWrap: true, // List flex container auto height
                          physics: const NeverScrollableScrollPhysics(), // Scroll main SingleChildScrollView handle karega
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 16,
                            right: 16,
                            bottom: 100, // Bottom nav ke space ke liye
                          ),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.55, // Updated ratio: prevents overflow with bottom date text
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: cardCount, // Displays at least 10 cards
                          itemBuilder: (context, index) {
                            final destination = state.destinations.isNotEmpty
                                ? state.destinations[index % state.destinations.length]
                                : null;

                            return DestinationCard(
                              destination: destination,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ===============================
              // FIXED BOTTOM NAVIGATION BAR
              // ===============================
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: HomeBottomNav(
                  selectedIndex: state.selectedBottomNav,
                  onChanged: (index) {
                    context
                        .read<HomeBloc>()
                        .add(BottomNavigationChanged(index));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}