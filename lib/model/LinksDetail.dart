// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clickern/main.dart';
import 'package:clickern/model/LinkDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../webview.dart';

class LinksDetail {
  late List<LinkDetail> linksDetail;
  LinksDetail({
    required this.linksDetail,
  });

  LinksDetail copyWith({
    List<LinkDetail>? linksDetail,
  }) {
    return LinksDetail(
      linksDetail: linksDetail ?? this.linksDetail,
    );
  }

  //String toJson() => json.encode(toMap());

  factory LinksDetail.fromJson(String source) {
    List<dynamic> jsonList = jsonDecode(source);
    List<LinkDetail> linksDetail = List.empty(growable: true);
    for (dynamic ele in jsonList) {
      linksDetail.add(LinkDetail.fromMap(ele));
    }
    return LinksDetail(linksDetail: linksDetail);
  }

  @override
  String toString() => 'LinksDetail(linksDetail: $linksDetail)';

  @override
  bool operator ==(covariant LinksDetail other) {
    if (identical(this, other)) return true;

    return other.linksDetail == linksDetail;
  }

  @override
  int get hashCode => linksDetail.hashCode;

  fetchFromServer() {
    http.post(Uri.parse(API_URL + "/fetchlist"),
        body: {'sessionId': sessionId}).then(
      (value) {
        List<dynamic> jsonList = jsonDecode(value.body);
        List<LinkDetail> linksDetail = List.empty(growable: true);
        for (dynamic ele in jsonList) {
          linksDetail.add(LinkDetail.fromMap(ele));
        }
      },
    );
  }

  factory LinksDetail.fromServer() {
    LinksDetail linksDetail = LinksDetail(linksDetail: List.empty());
    http.post(Uri.parse(API_URL + "/fetchlist"),
        body: {'sessionId': sessionId}).then(
      (value) {
        linksDetail = LinksDetail.fromJson(value.body);
      },
    );
    return linksDetail;
  }

  List<Widget> getViewWidget(BuildContext context) {
    List<Widget> res = <Widget>[];
    var srNo = 0;
    for (var ld in linksDetail) {
      srNo += 1;
      res.add(
        TextButton(
          onPressed: ld.click_count > 0
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext ctx) => WebView(
                        url: ld.short_link,
                        linkDetails: ld,
                        isEnableTimer: true,
                      ),
                    ),
                  ).then((value) => fetchFromServer());
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
                  ld.short_link,
                  style: ld.click_count > 0
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
    return res;
  }
}
