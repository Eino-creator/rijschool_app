import 'package:flutter/material.dart';
import 'package:rijschool_app/widgets/Lesson_card.dart';
import 'package:rijschool_app/widgets/empty_lesson_slot.dart';

class LessonsTimetable extends StatelessWidget {
  final List lessons;

  const LessonsTimetable({
    super.key,
    required this.lessons,
  });

  @override
  Widget build(BuildContext context) {
    final hours = List.generate(17, (index) => 6 + index);

    const double hourHeight = 90;

    return ListView.builder(
      itemCount: hours.length,
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemBuilder: (context, index) {
        final hour = hours[index];

        final firstDate = lessons.first.date.toDateTime();

        final hourStart = DateTime(
          firstDate.year,
          firstDate.month,
          firstDate.day,
          hour,
        );

        final hourEnd = hourStart.add(const Duration(hours: 1));

        final slotLessons = lessons.where((lesson) {
          final lessonStart = lesson.date.toDateTime();
          final lessonEnd = lesson.endDate.toDateTime();

          return lessonStart.isBefore(hourEnd) &&
              lessonEnd.isAfter(hourStart);
        }).toList();

        return Container(
          height: hourHeight,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 65,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16),
                  child: Text(
                    '${hour.toString().padLeft(2, '0')}:00',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),

              VerticalDivider(
                color: Colors.grey.shade100,
                thickness: 1,
                width: 1,
              ),

              if(slotLessons.isNotEmpty)
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: slotLessons.map((lesson) {
                    final lessonStart = lesson.date.toDateTime();

                    final startOffset = lessonStart.difference(hourStart).inMinutes;

                    final top = startOffset * (90 / 60);

                    return LessonCard(
                      lessons: lesson,
                      top: top,
                      onTap: () {},
                    );
                  }).toList()
                ),
              ),
              if(slotLessons.isEmpty)
                Expanded(
                  child: EmptyLessonCard(
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
