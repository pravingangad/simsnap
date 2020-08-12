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
              itemCount: snapshot.data.documents?.length ?? 0,
              itemBuilder: (context, index) {
                DocumentSnapshot loandata = snapshot.data.documents[index];
                var loan = loandata['loan_account_number'];
                var name = loandata['customer_name'];
                var icontext = loan.substring(0, 3);

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.redAccent ,
                    child: Text(icontext
                    ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white))
                  ),
                  title: Text('$loan'),
                  subtitle: Text('$name'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoanDetails(loan, name)),
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
