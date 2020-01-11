import 'package:flutter/material.dart';
import 'CCList.dart';

void main() => runApp(CCTracker());

// hasn`t state
class CCTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cryptocurrency prices',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CCList());
  }
}
