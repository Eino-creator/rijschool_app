import 'package:flutter/material.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';
import 'package:rijschool_app/screens/create_lesson_screen.dart';
import 'package:rijschool_app/widgets/day_selector.dart';
import 'package:rijschool_app/widgets/lesson_list.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  late Future<dynamic> _lessonsFuture;

  DateTime? selectedDay = DateTime.now();



  @override
  void initState() {
    super.initState();
    _loadLessons();
  }

  void _loadLessons() {
    _lessonsFuture = ConnectorConnector.instance.getLessons().execute();
  }

  Future<void> _openCreateLesson() async {
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateLessonScreen(),
      ),
    );

    if (!mounted) return;

    if (created == true) {
      setState(_loadLessons);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: FutureBuilder(
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
                    onPressed: _openCreateLesson,
                    icon: const Icon(Icons.add),
                    label: const Text('Add lesson'),
                  ),
                ],
              ),
            );
          }


          return Column(
            children: [
              DaySelector(
                selectedDay: selectedDay,
                onDayPressed: (pressedDay) {
                  setState(() {
                    selectedDay = pressedDay;
                  });
                },
              ),

              Expanded(
                  child: LessonList(lessons: lessons),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateLesson,
        icon: const Icon(Icons.person_add),
        label: const Text('Add lesson'),
      ),
    );
  }
}
