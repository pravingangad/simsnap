import 'package:flutter/material.dart';
import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Loan List';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark, primaryColor: Colors.redAccent),
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: HomePage(),
      ),
    );
  }
}
