import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'package:fyp_bbms/models/blood_request.dart';

import 'khalti_payment_page.dart';

void main() => runApp(KhaltiPaymentApp());

class KhaltiPaymentApp extends StatelessWidget {
  const KhaltiPaymentApp({
    Key? key,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_5e42bbb90c8c4f9ba1d8ce491562575a",
        builder: (context, navigatorKey) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            theme: ThemeData(
                primaryColor: const Color(0xFF56328c),
                appBarTheme: const AppBarTheme(
                  color: Color(0xFF56328c),
                )),
            title: 'Khalti Payment',
            home: KhaltiPaymentPage(),
          );
        });
  }
}
