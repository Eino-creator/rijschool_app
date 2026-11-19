import 'package:flutter/material.dart';

class EmptyLessonCard extends StatefulWidget {
  final VoidCallback? onTap;

  const EmptyLessonCard({super.key, this.onTap});

  @override
  State<EmptyLessonCard> createState() => _EmptyLessonCardState();
}

class _EmptyLessonCardState extends State<EmptyLessonCard> {
  bool _isHovered = false;


  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        opacity: _isHovered ? 1.0 : 0.0,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 90,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.5),
                ),
              ),
              child: const Center(
                child: Text(
                  'Click to schedule',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}