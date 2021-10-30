import 'dart:convert';

import 'package:clickern/dashboard.dart';
import 'package:clickern/login_page.dart';
import 'package:clickern/model/common.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

bool isLoggedIn = false;
// ignore: constant_identifier_names
const String API_URL = 'https://clickern.000webhostapp.com';
String sessionId = '';
SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  sessionId =
      prefs!.containsKey('sessionId') ? prefs!.getString('sessionId')! : '';
  isLoggedIn =
      prefs!.containsKey('isLoggedIn') ? prefs!.getBool('isLoggedIn')! : false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue, primaryColorDark: Colors.black12),
        home: const LoginPage());
  }
}
