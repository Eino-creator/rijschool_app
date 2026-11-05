import 'package:flutter/material.dart';

class DaySelector extends StatelessWidget {
  List<DateTime> getCurrentWeek() {
    final today = DateTime.now();

    final monday = today.subtract(
        Duration(days: today.weekday - 1)
    );

    return List.generate(
      7,
        (index) => monday.add(Duration(days: index)),
    );
  }


  const DaySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final days = getCurrentWeek();
    final today = DateTime.now();

    const dayNames = [
      'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: List.generate(7, (index) {
            final date = days[index];

            final isToday =
                date.year == today.year &&
                date.month == today.month &&
                date.day == today.day;

            return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      dayNames[index],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isToday
                            ? Colors.blue
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isToday
                            ? Colors.white
                            : Colors.black,
                        ),
                      ),
                    )
                  ],
                )
            );
          }
        ),
      ),
    ),
    );
  }
}