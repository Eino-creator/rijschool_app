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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _isHovered
                  ? Colors.green.withValues(alpha: 0.08)
                  : Colors.grey.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isHovered
                    ? Colors.green.withValues(alpha: 0.5)
                    : Colors.grey.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: _isHovered ? Colors.green : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isHovered ? 'Click to schedule' : 'Available slot',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: _isHovered
                              ? Colors.green.shade700
                              : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Add a new driving lesson',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_isHovered) ...[
                  const SizedBox(width: 8),
                  Icon(
                    Icons.add_circle_outline,
                    size: 18,
                    color: Colors.green.shade700,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}