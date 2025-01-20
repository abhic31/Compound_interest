import 'package:flutter/material.dart';
import 'screens/calculator_screen.dart';

void main() {
  runApp(CompoundInterestApp());
}

class CompoundInterestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traders  Compound Interest Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalculatorScreen(),
    );
  }
}
