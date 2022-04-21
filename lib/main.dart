import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fyp_bbms/auth/login.dart';
import 'package:fyp_bbms/blood_request/map_blood_request.dart';
import 'package:fyp_bbms/bottom_nav/blood_request_page.dart';

import 'package:fyp_bbms/home.dart';
import 'package:fyp_bbms/providers/donor_register_provider.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high-importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up: ${message.messageId}');
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  Get.testMode = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic('user');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<DonorRegisterProvider>(
            create: (_) => DonorRegisterProvider()),
      ],
      child: Builder(builder: (context) {
        Provider.of<AuthProvider>(context, listen: false).tryAutoLogin();
        return GetMaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: Consumer<AuthProvider>(
            builder: (context, value, child) =>
                value.userName == '' ? Login() : HomePage(),
          ),
          title: 'BBSM',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
        );
      }),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container();
    // return Navigator(
    //   // initialRoute: '/',
    //   onGenerateRoute: (RouteSettings settings) {
    //     WidgetBuilder builder;
    //     switch (settings.name) {
    //       case '/home':
    //         // navigates to 'signup/choose_credentials'.
    //         builder = (BuildContext _) => HomePage();
    //         break;
    //       // case 'home/createpage':
    //       //   builder = (BuildContext _) => new CreateRoomPage();
    //       //   break;
    //       // case 'home/presentation':
    //       //   builder = (BuildContext _) => new Presentation();
    //       //   break;
    //       default:
    //         throw new Exception('Invalid route: ${settings.name}');
    //     }
    //     return new MaterialPageRoute(builder: builder, settings: settings);
    //   },
    // );
  }
}
