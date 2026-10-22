
import 'package:flutter/material.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';
import 'package:rijschool_app/screens/create_lesson_screen.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  late Future<dynamic> _lessonsFuture;

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
        title: const Text('My Lessons'),
        actions: [
          IconButton(
            onPressed: _openCreateLesson,
            icon: const Icon(Icons.add),
            tooltip: 'Add lesson',
          ),
        ],
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

          return ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  leading: const Icon(Icons.school),
                  title: Text(lesson.pupil.name),
                  subtitle: Text(
                    'Status: ${lesson.status}\n'
                        'Payment: ${lesson.paymentStatus}\n'
                        'Cost: €${lesson.cost.toStringAsFixed(2)}\n'
                        'Date: ${lesson.date.toDateTime().toLocal()}',
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
