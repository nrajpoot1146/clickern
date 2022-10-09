import 'dart:convert';
import 'package:clickern/main.dart';
import 'package:clickern/model/LinkDetail.dart';
import 'package:clickern/model/LinksDetail.dart';
import 'package:clickern/webview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LinkList extends StatefulWidget {
  const LinkList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LinkListState();
}

class LinkListState extends State<LinkList> {
  Map<String, dynamic>? data;
  bool isLoaded = false;
  // ignore: non_constant_identifier_names
  List<Widget> link_list = <Widget>[];

  String tempData = 'naren';
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    LinksDetail linksDetail = LinksDetail.fromServer();
    //List<Widget> te = linksDetail.getViewWidget(context);

    link_list.clear();
    http.post(Uri.parse(API_URL + "/fetchlist"),
        body: {'sessionId': sessionId}).then((value) {
      final List<dynamic> templist = jsonDecode(value.body);
      //LinksDetail linksDetail = LinksDetail.fromJson(value.body);

      var srNo = 0;
      for (var element in templist) {
        srNo += 1;
        link_list.add(
          TextButton(
            onPressed: int.parse(element['click_count'].toString()) > 0
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext ctx) => WebView(
                          url: element['short_link'],
                          linkDetails: element,
                          isEnableTimer: true,
                        ),
                      ),
                    ).then((value) => fetchData());
                  },
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    srNo.toString() + '.',
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Text(
                    element['short_link'],
                    style: int.parse(element['click_count'].toString()) > 0
                        ? GoogleFonts.actor(color: Colors.black)
                        : GoogleFonts.actor(),
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: Text(
                //     element['click_count'].toString(),
                //   ),
                // )
              ],
            ),
          ),
        );
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
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: link_list,
              ),
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
                padding: EdgeInsets.all(0),
              ),
            ),
    );
  }
}
