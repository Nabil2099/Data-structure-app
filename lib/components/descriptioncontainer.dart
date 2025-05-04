import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> children;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;

  const InfoCard({
    Key? key,
    required this.title,
    this.subtitle,
    required this.children,
    this.backgroundColor = const Color(0xFF121212),
    this.titleColor = Colors.white,
    this.subtitleColor = const Color(0xFF4CAF50),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(width: 8),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: subtitleColor,
            ),
          ),
        ],
      ],
    );
  }
}

// Example section widgets to use inside InfoCard
class InfoCardSection extends StatelessWidget {
  final String title;
  final List<String> bulletPoints;
  final Color titleColor;
  final Color bulletPointColor;

  const InfoCardSection({
    Key? key,
    required this.title,
    required this.bulletPoints,
    this.titleColor = Colors.white,
    this.bulletPointColor = Colors.white70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 10),
        ...bulletPoints.map((point) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• ',
                style: TextStyle(
                  color: bulletPointColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  point,
                  style: TextStyle(color: bulletPointColor),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}

class CodeSection extends StatelessWidget {
  final String code;
  final String? language;

  const CodeSection({
    Key? key,
    required this.code,
    this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (language != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                language!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Text(
            code,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class ProConSection extends StatelessWidget {
  final List<String> pros;
  final List<String> cons;

  const ProConSection({
    Key? key,
    required this.pros,
    required this.cons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: InfoCardSection(
            title: 'Pros',
            bulletPoints: pros,
            titleColor: Colors.white,
            bulletPointColor: Colors.green,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: InfoCardSection(
            title: 'Cons',
            bulletPoints: cons,
            titleColor: Colors.white,
            bulletPointColor: Colors.red,
          ),
        ),
      ],
    );
  }
}