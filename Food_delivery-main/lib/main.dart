import 'package:flutter/material.dart';
import 'package:foddie_app/admin/Add_food_Page.dart';
import 'package:foddie_app/admin/Admin_Welcom_page.dart';
import 'package:foddie_app/admin/Admin_home_page.dart';
import 'package:foddie_app/admin/Admin_login_page.dart';
import 'package:foddie_app/admin/Admin_register_page.dart';
import 'package:foddie_app/admin/admin_edit_profile_page.dart';
import 'package:foddie_app/admin/admin_profile_page.dart';
import 'package:foddie_app/componets/LOGIN.DART';
import 'package:foddie_app/componets/forgot.dart';
import 'package:foddie_app/componets/landing_page.dart';
import 'package:foddie_app/componets/signup.dart';
import 'package:foddie_app/views/Home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: AdminRegisterPage(),
      //home: LoginScreen(),
      home: SignUpScreen(),
      //home: AdminLoginPage(),
      // home: AdminWelcomePage(),
      //home: AddFoodPage(),
      //home: ForgotPasswordScreen(),
      //home: HomePage(),
      //home: AddFoodPage(),
      // home: AdminProfilePage(),
      // home: AdminHomePage(),
      //home: AdminEditProfilePage(),
    );
  }
}
