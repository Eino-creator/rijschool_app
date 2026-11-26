import 'package:material_ui/material_ui.dart';
import 'package:rijschool_app/screens/lesson_screen.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';

class LessonCard extends StatelessWidget {
  final GetLessonsByDayLessons lessons;
  final ValueChanged<GetLessonsByDayLessons>? onLongPress;
  final double top;

  const LessonCard({
    super.key,
    required this.lessons,
    this.onLongPress,
    this.top = 0,
  });

  @override
  Widget build(BuildContext context) {
    final lessonStart = lessons.date.toDateTime().toLocal();
    final lessonEnd = lessons.endDate.toDateTime().toLocal();

    debugPrint('TIMETABLE UTC: ${lessons.date.toDateTime().toUtc()}');
    debugPrint('TIMETABLE LOCAL: ${lessons.date.toDateTime()}');

    final durationMinutes =
        lessonEnd.difference(lessonStart).inMinutes;

    final cardHeight = (durationMinutes / 60) * 90;

    return Positioned(
      top: top,
      left: 4,
      right: 4,
      height: cardHeight < 50 ? 50 : cardHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonScreen(id: lessons.id),
                  ),
            );
          },
          onLongPress: () => onLongPress?.call(lessons),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.green.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: Colors.green,
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
                        '${lessons.pupil.name} • ${lessons.paymentStatus}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.green,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 2),

                      Text(
                        '${_formatTime(lessonStart)} - '
                            '${_formatTime(lessonEnd)}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }
}
