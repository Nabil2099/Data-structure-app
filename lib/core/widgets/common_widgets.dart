import 'package:flutter/material.dart';

class ComplexityBadge extends StatelessWidget {
  final String complexity;
  const ComplexityBadge({super.key, required this.complexity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0C8159).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF3FB950), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.speed, size: 14, color: Color(0xFF3FB950)),
          const SizedBox(width: 6),
          Text(
            complexity,
            style: const TextStyle(
              color: Color(0xFF3FB950),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ExplanationCard extends StatelessWidget {
  final String operation;
  final String complexity;
  final String? error;
  final Widget? extra;

  const ExplanationCard({
    super.key,
    required this.operation,
    required this.complexity,
    this.error,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF181A1B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: Color(0xFF3FB950), size: 18),
              const SizedBox(width: 8),
              const Text(
                'Explanation',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              ComplexityBadge(complexity: complexity),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            operation,
            style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
          ),
          if (error != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber, color: Colors.redAccent, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      error!,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (extra != null) ...[
            const SizedBox(height: 12),
            extra!,
          ],
        ],
      ),
    );
  }
}

class VisualizerControl extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool primary;
  final bool enabled;

  const VisualizerControl({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.primary = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: enabled ? onPressed : null,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: primary
            ? const Color(0xFF3FB950)
            : const Color(0xFF232323),
        foregroundColor: primary ? Colors.black : Colors.white,
        disabledBackgroundColor: Colors.grey[800],
        disabledForegroundColor: Colors.white38,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.message,
    required this.icon,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF181A1B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.white24),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(color: Colors.white54, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0C8159),
                foregroundColor: Colors.white,
              ),
              child: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ],
          ),
        ),
        if (action != null) action!,
      ],
    );
  }
}

class TopicCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final double progress;
  final VoidCallback onTap;
  final bool isBookmarked;

  const TopicCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.progress,
    required this.onTap,
    this.isBookmarked = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
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
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C8159).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: const Color(0xFF3FB950), size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        description,
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                if (isBookmarked)
                  const Icon(Icons.bookmark, color: Color(0xFF3FB950), size: 20),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress / 100,
                backgroundColor: Colors.white10,
                valueColor: const AlwaysStoppedAnimation(Color(0xFF3FB950)),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${progress.toStringAsFixed(0)}% Complete',
                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                ),
                const Icon(Icons.arrow_forward, color: Colors.white38, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const ProgressCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    this.color = const Color(0xFF3FB950),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF181A1B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class QuizOptionCard extends StatelessWidget {
  final String option;
  final int index;
  final bool isSelected;
  final bool? isCorrect; // null = not revealed, true/false = feedback
  final VoidCallback onTap;
  final bool enabled;

  const QuizOptionCard({
    super.key,
    required this.option,
    required this.index,
    required this.isSelected,
    this.isCorrect,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.white12;
    Color bgColor = const Color(0xFF181A1B);
    IconData? trailingIcon;
    Color? trailingColor;

    if (isCorrect != null) {
      if (isCorrect == true) {
        borderColor = const Color(0xFF3FB950);
        bgColor = const Color(0xFF3FB950).withValues(alpha: 0.15);
        trailingIcon = Icons.check_circle;
        trailingColor = const Color(0xFF3FB950);
      } else if (isSelected) {
        borderColor = Colors.redAccent;
        bgColor = Colors.redAccent.withValues(alpha: 0.15);
        trailingIcon = Icons.cancel;
        trailingColor = Colors.redAccent;
      }
    } else if (isSelected) {
      borderColor = const Color(0xFF3FB950);
      bgColor = const Color(0xFF0C8159).withValues(alpha: 0.2);
    }

    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3FB950)
                    : Colors.white10,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index),
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              Icon(trailingIcon, color: trailingColor, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}
