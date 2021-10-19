import 'package:clickern/links_list.dart';
import 'package:clickern/login_page.dart';
import 'package:clickern/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  _onPressedLinkListButton() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext ctx) => const LinkList()));
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      Future.microtask(() => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) => const LoginPage())));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Clickern'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MenuItem(
                        title: 'Home', onPressed: _onPressedLinkListButton),
                    const Padding(padding: EdgeInsets.all(10)),
                    MenuItem(
                        title: 'Profile', onPressed: _onPressedLinkListButton)
                  ],
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MenuItem(
                        title: 'Links List',
                        onPressed: _onPressedLinkListButton),
                    const Padding(padding: EdgeInsets.all(10)),
                    MenuItem(
                        title: 'Payment', onPressed: _onPressedLinkListButton)
                  ],
                )
              ],
            )));
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: 100,
        //color: Colors.indigo,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, color: Colors.blue.shade100),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
        ));
  }
}
