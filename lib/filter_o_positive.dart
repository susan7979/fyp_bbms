import 'package:flutter/material.dart';

class FilterOPositive extends StatelessWidget {
  const FilterOPositive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'O Positive',
          style: TextStyle(color: Colors.red[800]),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        elevation: 0,
        backgroundColor: Colors.grey[50],
      ),
    );
  }
}
