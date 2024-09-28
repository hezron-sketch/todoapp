import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'assets/todohome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.spaceGroteskTextTheme()),
      home: TodoHome(),
    );
  }
}
