import 'package:flutter/material.dart';
import 'package:test12/pages/Google tanslate page .dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Google translate",
      home: GoogleTranslatePage (),
    );
  }
}

