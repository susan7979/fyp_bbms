import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fyp_bbms/auth/login.dart';
import 'package:fyp_bbms/auth/register.dart';
import 'package:fyp_bbms/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BBSM',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: AnimatedSplashScreen(
          splash: Image.asset('assets/images/launch_image.png'),
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.red,
          nextScreen: HomePage()),
      onGenerateRoute: (settings) {},
      routes: {
        Login.routeName: (context) => Login(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
    // return Scaffold(
    //   body: SafeArea(
    //     child: Container(
    //       width: double.infinity,
    //       height: MediaQuery.of(context).size.height,
    //       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
    //       child: SingleChildScrollView(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: <Widget>[
    //             Column(
    //               children: <Widget>[
    //                 const Text(
    //                   "Welcome",
    //                   style:
    //                       TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
    //                 ),
    //                 const SizedBox(
    //                   height: 20,
    //                 ),
    //               ],
    //             ),
    //             Container(
    //               height: MediaQuery.of(context).size.height / 3,
    //               // decoration: BoxDecoration(
    //               //     image: DecorationImage(
    //               //         image: AssetImage('assets/illustration.png'))),
    //             ),
    //             Column(
    //               children: <Widget>[
    //                 MaterialButton(
    //                   minWidth: double.infinity,
    //                   height: 60,
    //                   onPressed: () {
    //                     Navigator.push(context,
    //                         MaterialPageRoute(builder: (context) => Login()));
    //                   },
    //                   color: Colors.redAccent,
    //                   shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(50)),
    //                   child: Text(
    //                     "Login",
    //                     style: TextStyle(
    //                         fontWeight: FontWeight.w600, fontSize: 18),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Container(
    //                   padding: EdgeInsets.only(top: 3, left: 3),
    //                   child: MaterialButton(
    //                     minWidth: double.infinity,
    //                     height: 60,
    //                     onPressed: () {
    //                       Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                               builder: (context) => Register()));
    //                     },
    //                     color: Colors.redAccent,
    //                     elevation: 0,
    //                     shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(50)),
    //                     child: Text(
    //                       "Sign up",
    //                       style: TextStyle(
    //                           fontWeight: FontWeight.w600, fontSize: 18),
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
