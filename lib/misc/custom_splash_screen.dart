// import 'package:flutter/material.dart';
// import 'package:fyp_bbms/main.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState

//     super.initState();
//     // _navigateToMain();
//   }

//   _navigateToMain() async {
//     await Future.delayed(Duration(milliseconds: 500), () {});
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => MyHomePage()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 100,
//               width: 100,
//               color: Colors.red,
//             ),
//             Container(
//               child: Text(
//                 'Splash Screen',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
