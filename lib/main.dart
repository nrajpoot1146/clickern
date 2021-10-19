import 'package:clickern/dashboard.dart';
import 'package:clickern/login_page.dart';
import 'package:flutter/material.dart';

bool isLoggedIn = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        home: isLoggedIn ? const Dashboard() : const LoginPage());
  }
}
