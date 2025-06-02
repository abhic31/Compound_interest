import 'package:flutter/material.dart';

class ResultTable extends StatelessWidget {
  final List<Map<String, dynamic>> result;

  ResultTable({required this.result});

  @override
  Widget build(BuildContext context) {
    return result.isEmpty
        ? Center(
            child: Text(
              'No results to display',
              style: TextStyle(fontSize: 16),
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal, // <-- horizontal scroll
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical, // <-- vertical scroll
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Trade Number', textAlign: TextAlign.center),
                    ),
                  ),
                  DataColumn(
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Interest Earned', textAlign: TextAlign.center),
                    ),
                  ),
                  DataColumn(
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Total Amount', textAlign: TextAlign.center),
                    ),
                  ),
                ],
                rows: result
                    .map(
                      (row) => DataRow(
                        cells: [
                          DataCell(Text(row['trade'].toString())),
                          DataCell(Text(row['interest'])),
                          DataCell(Text(row['sum'])),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          );
  }
}
