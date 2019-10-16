import 'dart:convert';

import 'package:html/parser.dart' ;
//part 'cats.g.dart';

//@JsonSerializable()
class News {
  String Date_Time;
  String Header;
  String Details;

  News({this.Date_Time, this.Header, this.Details});

//  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
//
//  Map<String, dynamic> toJson() => _$NewsToJson(this);

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        Header: json['Header'],
        Details: _parseHtmlString(json['Details']),
        Date_Time:json["Date_Time"]
    );
  }
}

///to hold list of news
//@JsonSerializable()
class NewsList {
  List<News> newses;

  NewsList({this.newses});

  factory NewsList.fromJson(List<dynamic> json) {
    return NewsList(
        newses: json
            .map((e) => News.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

/////////////
 String _parseHtmlString(String htmlString) {
  var document = parse(htmlString);

  String parsedString = parse(document.body.text).documentElement.text;
//  StringBuffer sb = new StringBuffer();
//  sb.write(parsedString);
//  LineSplitter ls = new LineSplitter();
//  List<String> lines = ls.convert(parsedString);
  //var str=parsedString.replaceAll("/<.*?>/gm", '');
  return parsedString.replaceAll("\\n", "\n");
}
/////////////////////
String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true
  );

  return htmlText.replaceAll(exp, '');
}