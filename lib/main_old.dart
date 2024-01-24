import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:psc_119_ss/home/main_home.dart';
import 'package:psc_119_ss/home/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PSC 119 Bangka',
      theme: ThemeData(
        textTheme: GoogleFonts.manropeTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MainHomePage(),
      // home: LoginPage(),
    );
  }
}
