import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final String title;
  final String paragraph;
  final VoidCallback onPressed;
  final IconData? icon;

  const MyContainer({
    super.key,
    required this.title,
    required this.paragraph,
    required this.onPressed,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF181A1B),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(width: 10),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            paragraph,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.read_more, color: Color(0xFF3FB950)),
              TextButton(
                onPressed: onPressed,
                child: const Text(
                  "Read More",
                  style: TextStyle(fontSize: 16, color: Color(0xFF3FB950)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
