import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';
import 'package:rijschool_app/widgets/pupil_lesson_card.dart';

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
              return PupilLessonCard(lesson: lesson);
            },
          );
        },
      ),
    );
  }
}
