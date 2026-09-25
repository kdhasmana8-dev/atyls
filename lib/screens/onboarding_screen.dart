import 'package:flutter/material.dart';

import '../app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  final PageController controller =
  PageController();

  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'title': 'Discover Art',
      'description':
      'Explore beautiful artworks and discover new artists.',
    },
    {
      'title': 'Find Your Style',
      'description':
      'Browse collections that match your personal style.',
    },
    {
      'title': 'Start Exploring',
      'description':
      'Create your account and start your artistic journey.',
    },
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,

                itemCount: pages.length,

                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },

                itemBuilder:
                    (context, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.all(30),

                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [
                        Container(
                          height: 280,
                          width: double.infinity,

                          decoration:
                          BoxDecoration(
                            color:
                            AppColors.card,
                            borderRadius:
                            BorderRadius
                                .circular(20),
                          ),

                          child: const Icon(
                            Icons
                                .palette_outlined,
                            size: 100,
                            color:
                            AppColors.primary,
                          ),
                        ),

                        const SizedBox(height: 40),

                        Text(
                          pages[index]['title']!,
                          textAlign:
                          TextAlign.center,
                          style:
                          const TextStyle(
                            fontSize: 30,
                            fontWeight:
                            FontWeight.bold,
                            color: AppColors
                                .textPrimary,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          pages[index]
                          ['description']!,
                          textAlign:
                          TextAlign.center,
                          style:
                          const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: AppColors
                                .textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                    (index) {
                  return AnimatedContainer(
                    duration:
                    const Duration(
                      milliseconds: 250,
                    ),

                    margin:
                    const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),

                    height: 8,

                    width: currentPage == index
                        ? 25
                        : 8,

                    decoration:
                    BoxDecoration(
                      color:
                      currentPage == index
                          ? AppColors.primary
                          : AppColors.border,

                      borderRadius:
                      BorderRadius.circular(
                        20,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: ElevatedButton(
                onPressed: () {
                  if (currentPage ==
                      pages.length - 1) {
                    Navigator.pushReplacementNamed(
                      context,
                      '/login',
                    );
                  } else {
                    controller.nextPage(
                      duration:
                      const Duration(
                        milliseconds: 300,
                      ),
                      curve: Curves.easeInOut,
                    );
                  }
                },

                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  AppColors.primary,
                  foregroundColor:
                  AppColors.white,

                  minimumSize:
                  const Size(
                    double.infinity,
                    54,
                  ),

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                      12,
                    ),
                  ),
                ),

                child: Text(
                  currentPage ==
                      pages.length - 1
                      ? 'Get Started'
                      : 'Next',
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}