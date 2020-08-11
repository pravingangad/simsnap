import 'package:flutter/material.dart';
import 'package:simsnap/loan_details.dart';
// import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('loans').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          const Text('loading');
        } else {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot loandata = snapshot.data.documents[index];
                var loan = loandata['loanno'].toString();
                var name = loandata['customername'].toString();
                var regno = loandata['registrationno'].toString();
                var make = loandata['make'].toString();
                var model = loandata['model'].toString();

                return ListTile(
                  leading: Icon(Icons.filter_list),
                  title: Text(loandata['loanno']),
                  subtitle: Text(loandata['customername']),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoanDetails(loan, name, regno, make, model)),
                    );
                  },
                );
              });
        }
        return Container();
      },
    );
  }
}

// Container(
//           child: (FutureBuilder(
//         builder: (context, snapshot) {
//           var showData = json.decode(snapshot.data.toString());
//           return ListView.builder(
//             itemCount: showData.length,
//             itemBuilder: (BuildContext context, int index) {
//               var loan = showData[index]['loanaccountnumber'];
//               var name = showData[index]['customername'];
//               var regno = showData[index]['registrationnummber'];
//               var make = showData[index]['make'];
//               var model = showData[index]['model'];
//               return ListTile(
//                 leading: Icon(Icons.filter_list),
//                 title: Text(loan),
//                 subtitle: Text(name),
//                 trailing: Icon(Icons.chevron_right),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             LoanDetails(loan, name, regno, make, model)),
//                   );
//                 },
//               );
//             },
//           );
//         },
//         future:
//             DefaultAssetBundle.of(context).loadString('assets/loanlist.json'),
//       ))),
//     );
