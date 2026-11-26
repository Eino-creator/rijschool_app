import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';
import 'package:rijschool_app/screens/lesson_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<dynamic> _upcomingLessonsFuture;

  @override
  void initState() {
    super.initState();
    _loadUpcomingLessons();
  }

  Timestamp _toTimestamp(DateTime dateTime) {
    final utc = dateTime.toUtc();
    return Timestamp(
      (utc.millisecondsSinceEpoch % 1000) * 1000000,
      utc.millisecondsSinceEpoch ~/ 1000,
    );
  }

  void _loadUpcomingLessons() {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final endRange = startOfToday.add(const Duration(days: 7));

    _upcomingLessonsFuture = ConnectorConnector.instance
        .getLessonsByDay(
          startDate: _toTimestamp(startOfToday),
          endDate: _toTimestamp(endRange),
        )
        .execute();
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    }
    final tomorrow = now.add(const Duration(days: 1));
    if (date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day) {
      return 'Tomorrow';
    }
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _loadUpcomingLessons();
          });
          await _upcomingLessonsFuture;
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Lesson Schedule',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            FutureBuilder(
              future: _upcomingLessonsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Card(
                    color: Colors.red.withValues(alpha: 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Could not load schedule:\n${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('No lesson data received.'),
                    ),
                  );
                }

                final lessons = List<GetLessonsByDayLessons>.from(
                    snapshot.data!.data.lessons);

                final now = DateTime.now();
                lessons.sort((a, b) =>
                    a.date.toDateTime().compareTo(b.date.toDateTime()));

                GetLessonsByDayLessons? currentOrNext;
                GetLessonsByDayLessons? subsequent;

                for (int i = 0; i < lessons.length; i++) {
                  final l = lessons[i];
                  final end = l.endDate.toDateTime();
                  if (end.isAfter(now)) {
                    currentOrNext = l;
                    if (i + 1 < lessons.length) {
                      subsequent = lessons[i + 1];
                    }
                    break;
                  }
                }

                if (currentOrNext == null) {
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Icon(Icons.event_available,
                              size: 48, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          const Text(
                            'No upcoming lessons scheduled',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'You are all caught up for the next 7 days.',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final start = currentOrNext.date.toDateTime().toLocal();
                final end = currentOrNext.endDate.toDateTime().toLocal();
                final isHappeningNow = start.isBefore(now) && end.isAfter(now);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: isHappeningNow
                              ? Colors.green.shade400
                              : Colors.blue.shade300,
                          width: isHappeningNow ? 2 : 1,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LessonScreen(id: currentOrNext!.id),
                            ),
                          ).then((_) => setState(_loadUpcomingLessons));
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Chip(
                                    label: Text(
                                      isHappeningNow
                                          ? 'HAPPENING NOW'
                                          : 'UPCOMING',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: isHappeningNow
                                            ? Colors.green.shade800
                                            : Colors.blue.shade800,
                                      ),
                                    ),
                                    backgroundColor: isHappeningNow
                                        ? Colors.green.withValues(alpha: 0.15)
                                        : Colors.blue.withValues(alpha: 0.15),
                                  ),
                                  Text(
                                    _formatDate(start),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                currentOrNext.pupil.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.access_time, size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${_formatTime(start)} - ${_formatTime(end)}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '€${currentOrNext.cost.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
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
                    ),

                    if (subsequent != null) ...[
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_forward_ios,
                                size: 14, color: Colors.grey.shade600),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Next lesson: ${subsequent.pupil.name} on ${_formatDate(subsequent.date.toDateTime().toLocal())} at ${_formatTime(subsequent.date.toDateTime().toLocal())}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
