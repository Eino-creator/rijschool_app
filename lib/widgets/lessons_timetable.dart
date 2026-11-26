import 'package:material_ui/material_ui.dart';
import 'package:rijschool_app/widgets/lesson_card.dart';
import 'package:rijschool_app/widgets/empty_lesson_slot.dart';
import 'package:rijschool_app/widgets/create_lesson_widget.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';

class LessonsTimetable extends StatelessWidget {
  final List<GetLessonsByDayLessons> lessons;
  final ValueChanged<GetLessonsByDayLessons>? onLongPress;
  final VoidCallback? onLessonCreated;
  final DateTime selectedDay;

  const LessonsTimetable({
    super.key,
    required this.lessons,
    this.onLessonCreated,
    this.onLongPress,
    required this.selectedDay,
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

        final firstDate = selectedDay;

        final hourStart = DateTime(
          firstDate.year,
          firstDate.month,
          firstDate.day,
          hour,
        );

        final hourEnd = hourStart.add(const Duration(hours: 1));

        final slotLessons = lessons.where((lesson) {
          final lessonStart = lesson.date.toDateTime().toLocal();
          final lessonEnd = lesson.endDate.toDateTime().toLocal();

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
                    final lessonStart = lesson.date.toDateTime().toLocal();

                    final startOffset = lessonStart.difference(hourStart).inMinutes;

                    final top = startOffset * (90 / 60);

                    debugPrint('Lesson UTC: ${lesson.date.toDateTime().toUtc()}');
                    debugPrint('Lesson local: ${lesson.date.toDateTime().toLocal()}');
                    debugPrint('Hour start: $hourStart');

                    return LessonCard(
                      lessons: lesson,
                      onLongPress: (selectedLesson) {
                        onLongPress?.call(selectedLesson);
                      },
                      top: top,
                    );
                  }).toList()
                ),
              ),
              if(slotLessons.isEmpty)
                Expanded(
                  child: EmptyLessonCard(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: MediaQuery.of(context).size.height * 0.85,
                            ),
                            child: Scaffold(
                              backgroundColor: Colors.transparent,
                              appBar: AppBar(
                                title: const Text('Create lesson'),
                                leading: CloseButton(
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              body: CreateLessonWidget(
                                initialDate: hourStart,
                                initialStartTime: TimeOfDay(hour: hour, minute: 0),
                                initialEndTime: TimeOfDay(hour: hour + 1, minute: 0),
                                onLessonCreated: () {
                                  Navigator.pop(context, true);
                                },
                              ),
                            ),
                          ),
                        ),
                      ).then((created) {
                        if (created == true) {
                          onLessonCreated?.call();
                        }
                      });
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
