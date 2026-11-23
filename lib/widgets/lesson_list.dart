import 'package:material_ui/material_ui.dart';

class LessonList extends StatelessWidget {
  final List lessons;

  const LessonList({
    super.key,
    required this.lessons,
  });

  @override
  Widget build(BuildContext context) {
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
  }
}