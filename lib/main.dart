import 'package:flutter/material.dart';
import 'dart:async';
import 'package:xml2json/xml2json.dart' ;
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'dart:convert';

import 'news.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  NewsList newsList = NewsList();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
//  @override
//  void setState(fn) {
//    // TODO: implement setState
//    newsList = NewsList.fromJson(output);
//  }
  /////////////////////
  final Xml2Json xml2json=new Xml2Json();
  final String link="http://datafeed.mistnews.com/news5/service1.asmx/NewsTicker";
  void getData() async{
    http.Response response= await http.get(link);
    xml2json.parse(response.body);
    var jsondata=xml2json.toParker();
    var data=jsonDecode(jsondata);
    var output = data["DataSet"]["diffgr:diffgram"]["NewDataSet"]["News"];

   // var name = data["DataSet"]["diffgr:diffgram"]["NewDataSet"]["News"]["Header"];
    //var time = data["DataSet"]["diffgr:diffgram"]["NewDataSet"]["News"]["Date_Time"];
    //var details = [data["DataSet"]"diffgr:diffgram"]["NewDataSet"]["News"]["Details"];

    print(data);
    setState(() {
      newsList = NewsList.fromJson(output);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.print,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>getNews()));
                  //getData();
                })]
      ),
      body:  ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
//                    leading: CircleAvatar(
//                      backgroundImage: NetworkImage(snapshot.data[index].image),
//                    ),
            title: Text(newsList.newses[index].Header,textAlign: TextAlign.end,),
            subtitle: Text(newsList.newses[index].Details,textAlign: TextAlign.end,),
          );
        },
        itemCount: (newsList == null || newsList.newses == null || newsList.newses.length == 0) ? 0 : newsList.newses.length,      ),
    );
  }
}
