import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class EvalutionPage extends StatefulWidget{
  List ? summary;

  EvalutionPage(this.summary);

  @override
  State<StatefulWidget> createState() {
   return EvalutionPageState(this.summary);
  }

}
class EvalutionPageState extends State<EvalutionPage>{
  List ? summary;

  EvalutionPageState(this.summary);

  Future<List?>evalutionData () async{

    String myurl = 'http://localhost:5000//EvaSummary';
    var response;
    try {

      response = await http.post(Uri.parse(myurl),
          headers: {
            'Accept': 'application/json',
            "Access-Control_Allow_Origin": "*"
          },
          body: {

          }
      );

      return jsonDecode(response.body);

    }

    catch (e) {


    }

  }




  @override
  Widget build(BuildContext context) {
  return Scaffold(body:
    ListView(children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Text('MAP  :  '+summary![0]['MAP'],textAlign: TextAlign.center,style: TextStyle(color: Colors.red ,fontSize: 20,fontWeight: FontWeight.bold),),
      Text('MRR  :  '+summary![0]['MRR'],textAlign: TextAlign.center,style: TextStyle(color: Colors.red ,fontSize: 20,fontWeight: FontWeight.bold),),
      Text('P@10  :  '+summary![0]['P@10'],textAlign: TextAlign.center,style: TextStyle(color: Colors.red ,fontSize: 20,fontWeight: FontWeight.bold),)
    ],),
    Padding(padding: EdgeInsets.only(top: 20)),
    FutureBuilder( future:evalutionData(),
    builder: (BuildContext context, AsyncSnapshot snapshot)
    {
    if (snapshot.hasData) {
    return ListView.builder(
    shrinkWrap: true,
    itemCount: snapshot.data.length,
    scrollDirection: Axis.vertical,
    itemBuilder: (BuildContext context, int postion) {
    return Column(children: [
    ListTile(
    tileColor: Colors.grey,
    title: Text("query ID:"+(snapshot.data[postion]['key']).toString(),textAlign: TextAlign.center,),
    subtitle:Text( "prescion :  "+snapshot.data[postion]['prescion']+"    recall  :   "+snapshot.data[postion]['recall'],
    overflow: TextOverflow.ellipsis,

    ),
    ),
    Padding(padding:EdgeInsets.only(top: 10) ,)]);
    }
    );
    }
    else
      return Center(child:CircularProgressIndicator(),);
    }

  )]));


}
}