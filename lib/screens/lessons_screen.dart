import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';
import 'package:rijschool_app/widgets/create_lesson_widget.dart';
import 'package:rijschool_app/widgets/day_selector.dart';
import 'package:rijschool_app/widgets/lessons_timetable.dart';
import 'package:rijschool_app/extentions/date_time_extention.dart';

import '../widgets/edit_lesson_widget.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  late Future<dynamic> _lessonsFuture;

  DateTime? selectedDay = DateTime.now();

  late final DateTime? startOfDay = selectedDay?.startOfDay;

  late final DateTime? endOfDay = startOfDay?.add(const Duration(days: 1));

  Timestamp _toTimestamp(DateTime dateTime) {
    final utc = dateTime.toUtc();

    return Timestamp(
      (utc.millisecondsSinceEpoch % 1000) * 1000000,
      utc.millisecondsSinceEpoch ~/ 1000,
    );
  }

  @override
  void initState() {
    super.initState();
    _loadLessons();
  }

  void _loadLessons() {
    final startOfDay = selectedDay!.startOfDay;
    final endOfDay = startOfDay.add(const Duration(days: 1));

    _lessonsFuture = ConnectorConnector.instance
        .getLessonsByDay(
      startDate: _toTimestamp(startOfDay),
      endDate: _toTimestamp(endOfDay),
    )
        .execute();
  }

  void _reloadLessons() {
    if (!mounted) return;
    setState(_loadLessons);
  }

  void _openCreateLessonModal() {
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
              initialDate: selectedDay,
              onLessonCreated: () {
                Navigator.pop(context, true);
              },
            ),
          ),
        ),
      ),
    ).then((created) {
      if (created == true) {
        _reloadLessons();
      }
    });
  }

  void _openEditLessonModal(GetLessonsByDayLessons lesson) {
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
              title: const Text('Edit lesson'),
              leading: CloseButton(
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: EditLessonWidget(
              lesson: lesson,
              onLessonEdited: () {
                Navigator.pop(context, true);
              },
            ),
          ),
        ),
      ),
    ).then((edited) {
      if (edited == true) {
        _reloadLessons();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: Column(
        children: [
          DaySelector(
            selectedDay: selectedDay,
            onDayPressed: (pressedDay) {
              setState(() {
                selectedDay = pressedDay;
                _loadLessons();
              });
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: _lessonsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Could not load lessons:\n${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text('No data received.'));
                }

                final lessons = snapshot.data!.data.lessons;

                if (lessons.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('No lessons yet. Add your first lesson!'),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: _openCreateLessonModal,
                          icon: const Icon(Icons.add),
                          label: const Text('Add lesson'),
                        ),
                      ],
                    ),
                  );
                }

                return LessonsTimetable(
                  lessons: lessons,
                  selectedDay: selectedDay!,
                  onLessonCreated: _reloadLessons,
                  onLongPress: _openEditLessonModal,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
