import 'package:flutter/material.dart';

class MyConstant {
  // field
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeUserService = '/userService';
  static String routeNurseService = '/nurseService';
  static String routeAddEditProfileNurse = '/addEditProfileNurse';

  static Color primary = Color(0xff115faf);
  static Color dart = Color(0xff00367f);
  static Color light = Color(0xff588ce1);

  static String domain = 'https://www.androidthai.in.th/art';

  // method
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dart,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dart,
        fontWeight: FontWeight.w700,
      );

  TextStyle h2wStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 16,
        color: dart,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3wStyle() => TextStyle(
        fontSize: 16,
        color: Colors.white54,
        fontWeight: FontWeight.normal,
      );

  BoxDecoration colorBox() => BoxDecoration(color: light);

  BoxDecoration gradienBox() => BoxDecoration(
        gradient: RadialGradient(
            colors: [Colors.white, primary],
            radius: 1.5,
            center: Alignment(0, -0.3)),
      );

  BoxDecoration imageBox() => BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/wall.png'), fit: BoxFit.cover),
      );
}
