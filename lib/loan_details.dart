import 'package:flutter/material.dart';
import 'package:simsnap/image_upload.dart';

class LoanDetails extends StatefulWidget {
  final String loan;
  final String name;
  final String regno;
  final String make;
  final String model;

  LoanDetails(this.loan, this.name, this.regno, this.make, this.model);

  @override
  _LoanDetailsState createState() => _LoanDetailsState();
}

class _LoanDetailsState extends State<LoanDetails> {
  double iconSize = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Customer Details'),
        ),
        body: ListView(
          children: <Widget>[
            Center(
                child: Text(
              'Customer Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            DataTable(
              columns: [
                DataColumn(label: Text('Customer')),
                DataColumn(label: Text('Customer Details')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Loan Account Number')),
                  DataCell(Text('${widget.loan}')),
                ]),
                DataRow(cells: [
                  DataCell(Text('customer Name')),
                  DataCell(Text('${widget.name}')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Registration Number')),
                  DataCell(Text('${widget.regno}')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Make')),
                  DataCell(Text('${widget.make}')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Model')),
                  DataCell(Text('${widget.model}')),
                ]),
              ],
            ),
            Container(
              child: RaisedButton(
                elevation: 4,
                textColor: Colors.white,
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageUpload()),
                  );
                },
                child: Text('upload image'),
              ),
            ),
          ],
        ));
  }
}
