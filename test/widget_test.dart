// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For connector, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rijschool_app/main.dart';

void main() {
  testWidgets('sees the login page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Login'), findsAny);
    expect(find.text('Welcome back!'), findsOne);
    expect(find.text('Email address'), findsOne);
    expect(find.text('Password'), findsOne);
  });
}
