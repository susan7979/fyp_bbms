import 'package:flutter/material.dart';
import 'package:fyp_bbms/misc/custom_app_bar.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
      key: key,
      title: 'About me',
    ));
  }
}
