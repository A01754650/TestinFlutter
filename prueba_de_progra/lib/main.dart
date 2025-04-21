import 'package:flutter/material.dart';
import 'views/adivina_view.dart';

void main() {
  runApp(AdivinaApp());
}

class AdivinaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adivina el Número',
      theme: ThemeData.dark(),
      home: Screen(),
    );
  }
}