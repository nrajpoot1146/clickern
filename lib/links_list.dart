import 'dart:convert';
import 'package:clickern/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LinkList extends StatefulWidget {
  const LinkList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LinkListState();
}

class LinkListState extends State<LinkList> {
  TextEditingController textEditingController = TextEditingController();
  String tempData = 'naren';
  Map<String, dynamic>? data;
  bool isLoaded = false;
  // ignore: non_constant_identifier_names
  List<Widget> link_list = <Widget>[];

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    http
        .get(Uri.parse('https://clickern.000webhostapp.com/name'))
        .then((value) {
      final List<dynamic> templist = jsonDecode(value.body);

      for (var element in templist) {
        link_list.add(TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext ctx) => WebViewExample(
                          url: element['short_link'],
                        )));
          },
          child: Text(element['short_link']),
        ));
      }

      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: isLoaded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: link_list,
            )
          : const Center(
              child: Padding(
                child: SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                  width: 32,
                  height: 32,
                ),
                padding: EdgeInsets.all(16),
              ),
            ),
    );
  }
}
