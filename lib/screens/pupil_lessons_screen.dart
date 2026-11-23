import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';
import 'package:rijschool_app/screens/lesson_screen.dart';

class PupilLessonsScreen extends StatefulWidget {
  const PupilLessonsScreen({super.key});

  @override
  State<PupilLessonsScreen> createState() => _PupilLessonsScreenState();
}

class _PupilLessonsScreenState extends State<PupilLessonsScreen> {
  late Future<dynamic> _pupilLessonsFuture;

  @override
  void initState() {
    super.initState();
    _pupilLessonsFuture = _loadPupilLessons();
  }

  Future<dynamic> _loadPupilLessons() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final userResult = await ConnectorConnector.instance
        .getMyUserId(firebaseUid: user.uid)
        .execute();

    final users = userResult.data.users;
    if (users.isEmpty) {
      throw Exception('Pupil profile not found');
    }

    final userId = users.first.id;

    return ConnectorConnector.instance
        .getLessonsByPupil(pupilID: userId)
        .execute();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lessons'),
      ),
      body: FutureBuilder(
        future: _pupilLessonsFuture,
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

          final lessons = List<dynamic>.from(snapshot.data!.data.lessons);

          if (lessons.isEmpty) {
            return const Center(child: Text('No lessons found.'));
          }

          lessons.sort((a, b) => b.date.toDateTime().compareTo(a.date.toDateTime()));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              final startDate = lesson.date.toDateTime();
              final endDate = lesson.endDate.toDateTime();

              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonScreen(id: lesson.id),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatDate(startDate),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Chip(
                              label: Text(
                                lesson.status.toUpperCase(),
                                style: const TextStyle(fontSize: 11),
                              ),
                              backgroundColor: lesson.status == 'completed'
                                  ? Colors.green.withValues(alpha: 0.15)
                                  : lesson.status == 'cancelled'
                                      ? Colors.red.withValues(alpha: 0.15)
                                      : Colors.blue.withValues(alpha: 0.15),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 16, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text(
                              '${_formatTime(startDate)} - ${_formatTime(endDate)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '€${lesson.cost.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
