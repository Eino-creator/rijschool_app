
import 'package:flutter/material.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:rijschool_app/dataconnect_generated/generated.dart';

class CreateLessonScreen extends StatefulWidget {
  const CreateLessonScreen({super.key});

  @override
  State<CreateLessonScreen> createState() => _CreateLessonScreenState();
}

class _CreateLessonScreenState extends State<CreateLessonScreen> {
  final _formKey = GlobalKey<FormState>();
  final _costController = TextEditingController(text: '64');
  final _notesController = TextEditingController();

  String? _pupilId;
  String _status = 'scheduled';
  String _paymentStatus = 'unpaid';
  DateTime? _date;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool _saving = false;

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
      final mutation = ConnectorConnector.instance.createLesson(
        date: _toTimestamp(start),
        endDate: _toTimestamp(end),
        status: _status,
        paymentStatus: _paymentStatus,
        cost: double.parse(_costController.text.trim()),
        pupilId: _pupilId!,
      ).notes(
        _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      );

      await mutation.execute();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lesson created successfully!')),
      );

      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not create lesson: $error')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _costController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create lesson')),
      body: FutureBuilder(
        future: ConnectorConnector.instance.getPupils().execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Could not load pupils:\n${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.data.users.isEmpty) {
            return const Center(
              child: Text('Add a pupil before creating a lesson.'),
            );
          }

          final pupils = snapshot.data!.data.users;

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _pupilId,
                  decoration: const InputDecoration(
                    labelText: 'Pupil',
                    border: OutlineInputBorder(),
                  ),
                  items: pupils.map((pupil) {
                    return DropdownMenuItem<String>(
                      value: pupil.id.toString(),
                      child: Text(pupil.name),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _pupilId = value),
                  validator: (value) =>
                  value == null ? 'Select a pupil' : null,
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
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => _pickTime(isStart: true),
                  child: Text(
                    _startTime == null
                        ? 'Choose start time'
                        : 'Start: ${_startTime!.format(context)}',
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => _pickTime(isStart: false),
                  child: Text(
                    _endTime == null
                        ? 'Choose end time'
                        : 'End: ${_endTime!.format(context)}',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
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
                    if (value != null) setState(() => _status = value);
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
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
                    if (value != null) {
                      setState(() => _paymentStatus = value);
                    }
                  },
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
      ),
    );
  }
}
