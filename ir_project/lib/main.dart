import 'package:flutter/material.dart';
import 'package:ir_project/evalutionPage.dart';
import 'package:ir_project/resultPage.dart';
import 'package:ir_project/searchPage.dart';
import 'package:ir_project/selectDataFile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        '/result': (BuildContext context) => ResultPage('',''),
        '/search': (BuildContext context) => SearchPage(''),
        '/eva': (BuildContext context) => EvalutionPage([]),
       
      },
      home: SelectDataFile(),
    );
  }
}
