import 'package:flutter/material.dart';
import 'view/pantallavelocimetro.dart';

void main() {
  runApp(VelocimetroApp());
}

class VelocimetroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Velocímetro',
      home: VelocimetroPantalla(),
      debugShowCheckedModeBanner: false,
    );
  }
}
