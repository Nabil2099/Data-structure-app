import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final String title;
  final String paragraph;
  final onPressed;
  const MyContainer({
    super.key,
    required this.title,
    required this.paragraph,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF3FB950).withOpacity(0.2),
            spreadRadius: 0.05,
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              paragraph
              ,style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.read_more,
                  color: Color(0xFF3FB950),
                ),
                TextButton(onPressed: onPressed,
                    child: Text("Read More",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF3FB950),
                      ),
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
