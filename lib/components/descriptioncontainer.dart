import 'package:flutter/material.dart';

class DescriptionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const DescriptionCard({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF181A1B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
