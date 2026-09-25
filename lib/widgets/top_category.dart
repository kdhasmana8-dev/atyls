import 'package:flutter/material.dart';

class TopCategory extends StatelessWidget {
  final String image;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const TopCategory({
    super.key,
    required this.image,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 58, // Compact circle size
            height: 58,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: selected
                  ? Colors.white
                  : const Color(0xFF91A7B3).withOpacity(0.6),
              shape: BoxShape.circle,
              boxShadow: selected
                  ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ]
                  : null,
            ),
            child: ClipOval(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                    size: 18,
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              color: selected ? Colors.black : const Color(0xFF555555),
            ),
          ),

          const SizedBox(height: 4),

          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2.5,
            width: selected ? 24 : 0, // Indicator line width adjusted
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}