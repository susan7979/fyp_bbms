import 'package:flutter/material.dart';

class FilterABNegative extends StatelessWidget {
  const FilterABNegative({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AB Negative',
          style: TextStyle(color: Colors.red[800]),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        elevation: 0,
        backgroundColor: Colors.grey[50],
      ),
    );
  }
}
