// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LinkDetail {
  String link_id;
  String short_link;
  String target_link;
  int click_count;
  String datetime;
  LinkDetail({
    required this.link_id,
    this.short_link = "",
    this.target_link = "",
    this.click_count = 0,
    required this.datetime,
  });

  LinkDetail copyWith({
    String? link_id,
    String? short_link,
    String? target_link,
    int? click_count,
    String? datetime,
  }) {
    return LinkDetail(
      link_id: link_id ?? this.link_id,
      short_link: short_link ?? this.short_link,
      target_link: target_link ?? this.target_link,
      click_count: click_count ?? this.click_count,
      datetime: datetime ?? this.datetime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'link_id': link_id,
      'short_link': short_link,
      'target_link': target_link,
      'click_count': click_count,
      'datetime': datetime,
    };
  }

  factory LinkDetail.fromMap(Map<String, dynamic> map) {
    return LinkDetail(
      link_id: map['link_id'] as String,
      short_link: map['short_link'] as String,
      target_link: map['target_link'] as String,
      click_count: map['click_count'] as int,
      datetime: map['datetime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LinkDetail.fromJson(String source) =>
      LinkDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LinkDetail(link_id: $link_id, short_link: $short_link, target_link: $target_link, datetime: $datetime)';
  }

  @override
  bool operator ==(covariant LinkDetail other) {
    if (identical(this, other)) return true;

    return other.link_id == link_id &&
        other.short_link == short_link &&
        other.target_link == target_link &&
        other.datetime == datetime;
  }

  @override
  int get hashCode {
    return link_id.hashCode ^
        short_link.hashCode ^
        target_link.hashCode ^
        datetime.hashCode;
  }

  Widget getViewWidget() {
    return Text(
      short_link,
      style: click_count > 0
          ? GoogleFonts.actor(color: Colors.black)
          : GoogleFonts.actor(),
    );
  }
}
