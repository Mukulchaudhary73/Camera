import 'package:flutter/cupertino.dart';
import 'package:scan_app/pages/home_page.dart';
import 'package:scan_app/pages/login_page.dart';
import 'package:scan_app/pages/signUp_page.dart';

class MyRoutes {
  static String loginRoute = "/login";
  static String homeRoute = "/home";
  static String signUpRoute = "/signUp";

  static Map<String, Widget Function(BuildContext context)> get routes => {
        homeRoute: (context) => const HomePage(),
        loginRoute: (context) => const LoginPage(),
        signUpRoute: (context) => const SignUpPage(),
      };
}
