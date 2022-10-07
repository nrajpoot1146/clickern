import 'package:clickern/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
// ignore: constant_identifier_names
// const String API_URL = 'http://clickern.co.in';
const String API_URL = 'https://clickern.knowyourelement.co.in';
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
        title: 'Clickern',
        theme: ThemeData(
            primarySwatch: Colors.blue, primaryColorDark: Colors.black12),
        home: const LoginPage());
  }
}
