import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/result_table.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _initialAmountController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _tradesController = TextEditingController();

  List<Map<String, dynamic>> _result = [];
  
  // To keep track of input validation messages
  String? _initialAmountError;
  String? _interestError;
  String? _tradesError;

  void calculateCompoundInterest() {
    final double initialAmount = double.tryParse(_initialAmountController.text) ?? 0.0;
    final double interest = double.tryParse(_interestController.text) ?? 0.0;
    final int trades = int.tryParse(_tradesController.text) ?? 0;

    // Validation
    setState(() {
      _initialAmountError = initialAmount <= 0 ? 'Enter a valid amount' : null;
      _interestError = interest <= 0 ? 'Enter a valid interest percentage' : null;
      _tradesError = trades <= 0 ? 'Enter a valid number of trades' : null;
    });

    if (_initialAmountError == null && _interestError == null && _tradesError == null) {
      // Only proceed if all inputs are valid
      List<Map<String, dynamic>> result = [];
      double currentAmount = initialAmount;

      for (int i = 1; i <= trades; i++) {
        double interestEarned = currentAmount * (interest / 100);
        currentAmount += interestEarned;
        result.add({
          'trade': i,
          'interest': interestEarned.toStringAsFixed(2),
          'sum': currentAmount.toStringAsFixed(2),
        });
      }

      setState(() {
        _result = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Traders Compound Interest Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _initialAmountController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              decoration: InputDecoration(
                labelText: 'Initial Amount',
                errorText: _initialAmountError,
              ),
            ),
            TextField(
              controller: _interestController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              decoration: InputDecoration(
                labelText: 'Interest per Trade (%)',
                errorText: _interestError,
              ),
            ),
            TextField(
              controller: _tradesController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
              ],
              decoration: InputDecoration(
                labelText: 'Number of Trades',
                errorText: _tradesError,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateCompoundInterest,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ResultTable(result: _result),
            ),
          ],
        ),
      ),
    );
  }
}
