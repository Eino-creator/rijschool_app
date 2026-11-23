import 'package:firebase_data_connect/firebase_data_connect.dart';

extension TimestampExtension on Timestamp {
  DateTime toDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(
      seconds * 1000 + nanoseconds ~/ 1000000,
      isUtc: true,
    ).toLocal();
  }
}