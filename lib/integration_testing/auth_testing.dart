// // @dart=2.9
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// // import 'package:fyp_bbms/auth/login.dart' as log;
// import 'package:fyp_bbms/auth/register.dart' as reg;
// import 'package:fyp_bbms/providers/auth_provider.dart' as app;
// import 'package:fyp_bbms/home.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:fyp_bbms/main.dart';

// import '../auth/login.dart';

// // import 'base.dart';

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   testWidgets(
//     'Login',
//     (WidgetTester tester) async {
//       await tester.pumpWidget(const MyApp());
//       await tester.pumpAndSettle();

//       await app.AuthProvider().login("gautamsusan15@gmail.com", "Qazplm@123");

//       expect(find.byType(HomePage).first, findsOneWidget);
//     },
//   );

//   testWidgets(
//     'Logout',
//     (WidgetTester tester) async {
//       await tester.pumpWidget(const MyApp());
//       await tester.pumpAndSettle();

//       final settingNB = find.byKey(const Key('settingNB'));
//       await tester.tap(settingNB);
//       await tester.pumpAndSettle();

//       final logoutButton = find.byKey(const Key('logoutFAB'));
//       await tester.tap(logoutButton);
//       await tester.pumpAndSettle();

//       expect(find.byType(AlertDialog).first, findsOneWidget);

//       final confirm = find.widgetWithText(TextButton, 'OK');
//       await tester.tap(confirm);
//       await tester.pumpAndSettle();

//       expect(find.byType(Login).first, findsOneWidget);
//     },
//   );

//   /* Unable to login cause: 
//     - Wrong credentia
//     - Connection issue
//     - In-active User
//   */
//   testWidgets(
//     'Wrong credential login',
//     (WidgetTester tester) async {
//       await tester.pumpWidget(const MyApp());
//       await tester.pumpAndSettle();

//       await app.AuthProvider().login("asd", "asd");

//       await expectLater(find.byType(SnackBar).first, findsOneWidget);
//     },
//   );
// }
