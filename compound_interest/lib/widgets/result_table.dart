import 'package:flutter/material.dart';

class ResultTable extends StatelessWidget {
  final List<Map<String, dynamic>> result;

  ResultTable({required this.result});

  @override
  Widget build(BuildContext context) {
    // Calculate totals
    double totalInterest = 0;
    double totalSum = 0;

    for (var row in result) {
      totalInterest += double.tryParse(row['interest'].toString()) ?? 0;
      totalSum += double.tryParse(row['sum'].toString()) ?? 0;
    }

    // Total header widget
    Widget totalDisplay(String label) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            '💰 $label: ${totalInterest.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );

    if (result.isEmpty) {
      return Center(
        child: Text(
          'No results to display',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // Top total display
          totalDisplay('Total Earned'),

          // Scrollable table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Trade Number')),
                DataColumn(label: Text('Interest Earned')),
                DataColumn(label: Text('Total Amount')),
              ],
              rows: [
                ...result.map(
                  (row) => DataRow(
                    cells: [
                      DataCell(Text(row['trade'].toString())),
                      DataCell(Text(row['interest'].toString())),
                      DataCell(Text(row['sum'].toString())),
                    ],
                  ),
                ),
                DataRow(
                  cells: [
                    DataCell(Text(
                      '💰 Total Earned',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text(
                      totalInterest.toStringAsFixed(2),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text(
                      totalSum.toStringAsFixed(2),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
