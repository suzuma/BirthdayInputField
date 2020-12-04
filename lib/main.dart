import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:input_birday/pages/home_page.dart';
import 'package:lol_colors_flutter/lol_colors_flutter.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulario Input Cumpleaños',
      theme: ThemeData(
        primarySwatch: LolColors.c1070_2,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
      ),
      home: HomePage(),
    );
  }
}
