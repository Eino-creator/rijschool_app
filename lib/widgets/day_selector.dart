import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';

class DaySelector extends StatelessWidget {
  final ValueChanged<DateTime> onDayPressed;
  final DateTime? selectedDay;

  const DaySelector({
    super.key,
    required this.onDayPressed,
    required this.selectedDay,
  });

  List<DateTime> getCurrentWeek() {
    final today = DateTime.now();

    final monday = today.subtract(
      Duration(days: today.weekday - 1),
    );

    return List.generate(
      16,
          (index) => monday.add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final days = getCurrentWeek();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 70,
          child:
          SizedBox(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: days.map((date) {
                final isToday = DateUtils.isSameDay(date, DateTime.now());
                final isSelected = DateUtils.isSameDay(date, selectedDay);

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onDayPressed(date),
                  child: SizedBox(
                    width: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected
                            ? Border.all(color: Colors.blue, width: 2)
                            :null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('EEE', 'nl_NL').format(date),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: isToday ? Colors.blue : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${date.day}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: isToday ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                );
              }).toList(),
            ),
          ),

        ),
      ),
    );
  }
}
