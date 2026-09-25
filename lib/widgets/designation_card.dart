import 'package:flutter/material.dart';

import '../models/designation_model.dart';

class DestinationCard extends StatelessWidget {
  final DestinationModel? destination;

  const DestinationCard({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    // Null-safe fallbacks agar model load na ho
    final String imagePath = destination?.image ?? 'assets/images/home_background.jpg';
    final String flagText = destination?.flag ?? '🌐';
    final String countryName = destination?.country ?? 'COUNTRY';
    final String validity = destination?.validDays ?? '30 DAYS';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // MAIN CARD
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // BACKGROUND IMAGE
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.image,
                          size: 30,
                        ),
                      );
                    },
                  ),

                  // DARK GRADIENT OVERLAY AT BOTTOM
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.85),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // CARD INNER CONTENT
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // FLAG / ICON
                        Text(
                          flagText,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // COUNTRY NAME
                        Text(
                          countryName.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.1,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'serif',
                            letterSpacing: 0.5,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // DIVIDER LINE
                        Container(
                          height: 0.8,
                          color: Colors.white.withOpacity(0.25),
                        ),

                        const SizedBox(height: 8),

                        // VALID & DAYS ROW
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'VALID',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              validity,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 6),

        // GUARANTEED BY DATE TEXT (Jaisa second screenshot me hai)
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Guaranteed By',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                '25 Sep 2026, 04:38 PM',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}