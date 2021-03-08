import 'package:flutter/material.dart';
import 'views/menu/view/menu_view.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rastaurant menu',
      theme: ThemeData(
        primaryTextTheme: TextTheme(
            bodyText1: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal),
            headline4: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500, color: Colors.white70),
            headline6: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400, color: Colors.white70)),
        primaryColor: Color(0xffF8F3DD),
        accentColor: Color(0xffB813441),
        focusColor: Color(0xfffacec8),
        primarySwatch: Colors.blue,
      ),
      home: MenuView(),
    );
  }
}
