import 'package:material_ui/material_ui.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';

class EditLessonWidget extends StatefulWidget {
  final DateTime? initialDate;
  final TimeOfDay? initialStartTime;
  final TimeOfDay? initialEndTime;
  final VoidCallback? onLessonEdited;
  final GetLessonsByDayLessons lesson;

  const EditLessonWidget({
    super.key,
    required this.lesson,
    this.initialDate,
    this.initialStartTime,
    this.initialEndTime,
    this.onLessonEdited,
  });

  @override
  State<EditLessonWidget> createState() => _EditLessonWidgetState();
}

class _EditLessonWidgetState extends State<EditLessonWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _costController;
  late final TextEditingController _notesController;
  late Future<dynamic> _pupilsFuture;

  String? _status;
  String? _paymentStatus;
  String? _pupilId;
  DateTime? _date;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool _saving = false;

  @override
  void initState() {
    super.initState();

    _costController = TextEditingController(
      text: widget.lesson.cost.toString(),
    );

    _notesController = TextEditingController(
      text: widget.lesson.notes ?? '',
    );

    _status = widget.lesson.status;
    _paymentStatus = widget.lesson.paymentStatus;
    _pupilId = widget.lesson.pupil.id;

    final lessonDate = widget.lesson.date.toDateTime().toLocal();
    final lessonEnd = widget.lesson.endDate.toDateTime().toLocal();

    _date = widget.initialDate ?? lessonDate;

    _startTime = widget.initialStartTime ??
        (TimeOfDay.fromDateTime(lessonDate));

    _endTime = widget.initialEndTime ??
        (TimeOfDay.fromDateTime(lessonEnd));

    _pupilsFuture =
        ConnectorConnector.instance.getPupils().execute();
  }

  @override
  void dispose() {
    _costController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  DateTime? _combineDateAndTime(TimeOfDay? time) {
    if (_date == null || time == null) return null;

    return DateTime(
      _date!.year,
      _date!.month,
      _date!.day,
      time.hour,
      time.minute,
    );
  }

  Timestamp _toTimestamp(DateTime dateTime) {
    final utc = dateTime.toUtc();

    return Timestamp(
      (utc.millisecondsSinceEpoch % 1000) * 1000000,
      utc.millisecondsSinceEpoch ~/ 1000,
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final selected = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 5),
    );

    if (selected != null) {
      setState(() => _date = selected);
    }
  }

  Future<void> _pickTime({required bool isStart}) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: isStart
          ? (_startTime ?? const TimeOfDay(hour: 9, minute: 0))
          : (_endTime ?? const TimeOfDay(hour: 10, minute: 0)),
    );

    if (selected != null) {
      setState(() {
        if (isStart) {
          _startTime = selected;
        } else {
          _endTime = selected;
        }
      });
    }
  }

  Future<void> _saveLesson() async {
    if (!_formKey.currentState!.validate()) return;

    final start = _combineDateAndTime(_startTime);
    final end = _combineDateAndTime(_endTime);

    if (_pupilId == null || _date == null ||
        start == null || end == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a pupil, date, and both times.'),
        ),
      );
      return;
    }

    if (!end.isAfter(start)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The end time must be after the start time.'),
        ),
      );
      return;
    }

    setState(() => _saving = true);

    try {
      final mutation = ConnectorConnector.instance.editLesson(
        id: widget.lesson.id,
        date: _toTimestamp(start),
        endDate: _toTimestamp(end),
        cost: double.parse(
          _costController.text.trim().replaceAll(',', '.'),
        ),
        pupilId: _pupilId!,
        status: _status!,
        paymentStatus: _paymentStatus!,
      ).notes(
        _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      );

      await mutation.execute();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lesson edited successfully!')),
      );

      if (widget.onLessonEdited != null) {
        widget.onLessonEdited!();
      } else {
        Navigator.pop(context, true);
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not edit lesson: $error')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _pupilsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Could not load pupils:\n${snapshot.error}'),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.data.users.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Add a pupil before editing a lesson.'),
            ),
          );
        }

        final List<dynamic> pupils = snapshot.data!.data.users;

        final List<DropdownMenuItem<String>> pupilItems = [];

        for (final pupil in pupils) {
          pupilItems.add(
            DropdownMenuItem<String>(
              value: pupil.id.toString(),
              child: Text(pupil.name.toString()),
            ),
          );
        }

        return Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              DropdownButtonFormField<String>(
                initialValue: pupilItems.any(
                      (item) => item.value == _pupilId,
                )
                    ? _pupilId
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Pupil',
                  border: OutlineInputBorder(),
                ),
                items: pupilItems,
                onChanged: (String? value) {
                  setState(() {
                    _pupilId = value;
                  });
                },
                validator: (String? value) {
                  return value == null ? 'Select a pupil' : null;
                },
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  _date == null
                      ? 'Choose lesson date'
                      : '${_date!.day}/${_date!.month}/${_date!.year}',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pickTime(isStart: true),
                      child: Text(
                        _startTime == null
                            ? 'Start time'
                            : 'Start: ${_startTime!.format(context)}',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pickTime(isStart: false),
                      child: Text(
                        _endTime == null
                            ? 'End time'
                            : 'End: ${_endTime!.format(context)}',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _status,
                      decoration: const InputDecoration(
                        labelText: 'Lesson status',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'scheduled',
                          child: Text('Scheduled'),
                        ),
                        DropdownMenuItem(
                          value: 'completed',
                          child: Text('Completed'),
                        ),
                        DropdownMenuItem(
                          value: 'cancelled',
                          child: Text('Cancelled'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _status = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      initialValue: _paymentStatus,
                      decoration: const InputDecoration(
                        labelText: 'Payment status',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'unpaid',
                          child: Text('Unpaid'),
                        ),
                        DropdownMenuItem(
                          value: 'paid',
                          child: Text('Paid'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _paymentStatus = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _costController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Cost (€)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final cost = double.tryParse(
                    (value ?? '').trim().replaceAll(',', '.'),
                  );
                  if (cost == null || cost < 0) {
                    return 'Enter a valid non-negative cost';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _saving ? null : _saveLesson,
                icon: const Icon(Icons.save),
                label: Text(_saving ? 'Saving...' : 'Save lesson'),
              ),
            ],
          ),
        );
      },
    );
  }
}
