import 'dart:convert';
import 'dart:ui';

import 'package:clickern/dashboard.dart';
import 'package:clickern/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  IconData eyeIcon = Icons.visibility;
  bool isPassVisible = false;
  bool _progressVisibility = false;
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPass = TextEditingController();

  _onPressedLoginButton() {
    setState(() {
      _progressVisibility = true;
    });
    var username = textEditingControllerEmail.text;
    var password = textEditingControllerPass.text;
    var data = {'username': username, 'password': password};

    http
        .post(Uri.parse('https://clickern.000webhostapp.com/login'), body: data)
        .then((value) {
      final Map responce = jsonDecode(value.body);
      if (responce['status'] == 'OK') {
        isLoggedIn = true;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext ctx) => const Dashboard()));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: const Text('Invalid username or password!'),
                actions: [
                  // ignore: deprecated_member_use
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK"))
                ],
              );
            });
      }
      setState(() {
        _progressVisibility = false;
      });
    });
  }

  _onPressedForgotPassButton() {}

  _onPressedPassEyeButton() {
    isPassVisible = !isPassVisible;
    setState(() {
      eyeIcon = isPassVisible ? Icons.visibility_off : Icons.visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/money.jpg'),
                  colorFilter: ColorFilter.linearToSrgbGamma(),
                  fit: BoxFit.cover)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Clickern Login',
                    style: GoogleFonts.amiri(
                      fontSize: 30,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  TextFormField(
                    controller: textEditingControllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isPassVisible,
                    controller: textEditingControllerPass,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: _onPressedPassEyeButton,
                            icon: Icon(eyeIcon))),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _onPressedForgotPassButton,
                        child: const Text('Forgot Password?'),
                      )
                    ],
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: MaterialButton(
                      onPressed: _onPressedLoginButton,
                      color: Colors.blue,
                      child: const Text(
                        'LogIn',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: _progressVisibility,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: const CircularProgressIndicator(),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
