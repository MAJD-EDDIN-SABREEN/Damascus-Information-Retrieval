import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ResultPage extends StatefulWidget{
  String ? searchtxt;
  String ? fileName;
  ResultPage(this.searchtxt,this.fileName);

  @override
  State<StatefulWidget> createState() {
    return ResultPageState(searchtxt,this.fileName);
  }

}
class ResultPageState extends State<ResultPage>{
  String ? searchtxt;
  String ? fileName;
  ResultPageState(this.searchtxt,this.fileName);


  Future<List?>resultData () async{
    print(searchtxt);
    String myurl = 'http://localhost:5000//Result';
    var response;
    try {

       response = await http.post(Uri.parse(myurl),
          headers: {
            'Accept': 'application/json',
            "Access-Control_Allow_Origin": "*"
          },
          body: {
            'query':searchtxt,
            'filename':'cacm.txt'
          }
      );

    return jsonDecode(response.body);

    }

    catch (e) {

    }

  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: FutureBuilder(
        future:resultData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print("yes");
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int postion) {
                  return Column(children: [
                    ListTile(
                    tileColor: Colors.grey,
                    title: Text((snapshot.data[postion]['key']).toString(),textAlign: TextAlign.center,),
                    subtitle:Text( snapshot.data[postion]['value'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
                  Padding(padding:EdgeInsets.only(top: 10) ,)]);
                }
            );
          }
          else
            return Center(child: CircularProgressIndicator(),);
        }
    )
    ,

    );

  }

}