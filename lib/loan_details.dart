import 'package:flutter/material.dart';
import 'package:simsnap/image_upload.dart';

class LoanDetails extends StatefulWidget {
  final String loan;
  final String name;
 

  LoanDetails(this.loan, this.name);
  @override
  _LoanDetailsState createState() => _LoanDetailsState();
}

class _LoanDetailsState extends State<LoanDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.loan),
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
              ],
            ),
            Container(
              padding: EdgeInsets.all(40),
              child: RaisedButton(
                elevation: 4,
                textColor: Colors.white,
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageUpload(widget.loan,widget.name)),
                  );
                },
                child: Text('Upload Image'),
              ),
            ),
          ],
        ));
  }
}
