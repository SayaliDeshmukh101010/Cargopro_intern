import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cargopro_intern_app/main.dart';
import 'package:cargopro_intern_app/modules/auth/login_view.dart';

void main() {
  testWidgets('App starts without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(GetMaterialApp(
      home: LoginView(),
    ));
    
    // Verify that login screen is shown
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Login screen has all required elements', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(
      home: LoginView(),
    ));

    // Verify all required elements are present
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Phone form switches to OTP form', (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(
      home: LoginView(),
    ));

    // Initially should show phone form
    expect(find.text('Send OTP'), findsOneWidget);
    
    // Tap the button to switch to OTP form
    await tester.tap(find.text('Send OTP'));
    await tester.pump();
    
    // Now should show OTP form
    expect(find.text('Verify OTP'), findsOneWidget);
  });
}