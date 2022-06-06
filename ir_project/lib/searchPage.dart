import 'dart:convert';

import 'package:auto_complete_search/auto_complete_search.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ir_project/evalutionPage.dart';
import 'package:ir_project/resultPage.dart';
class SearchPage extends StatefulWidget{
  String ? fileName;

  SearchPage(this.fileName);

  @override
  State<StatefulWidget> createState() {
    return SearchPageState(this.fileName);
  }

}
class SearchPageState extends State<SearchPage>{
  String ? fileName;
  List ? summary;
  final List myList=['''.I 1
.W
 What articles exist which deal with TSS (Time Sharing System), an
operating system for IBM computers?
.N
 1. Richard Alexander, Comp Serv, Langmuir Lab (TSS)
 ''','''.I 2
.W
 I am interested in articles written either by Prieve or Udo Pooch
.A
Prieve, B.
Pooch, U.
.N
 2. Richard Alexander, Comp Serv, Langmuir Lab (author = Pooch or Prieve)
 ''','''.I 3
.W
 Intermediate languages used in construction of multi-targeted compilers; TCOLL
.N
 3. Donna Bergmark, Comp Serv, Uris Hall (intermed lang)
''','''.I 5
.W
 I'd like papers on design and implementation of editing interfaces,
window-managers, command interpreters, etc.  The essential issues are
human interface design, with views on improvements to user efficiency,
effectiveness and satisfaction.
.N
''','''.I 64
.W
 List all articles on EL1 and ECL (EL1 may be given as EL/1; I don't
remember how they did it.
.N
 64. Hal Perkins, Comp Sci, Cornell
''','''
.I 8
.W
 Addressing schemes for resources in networks; resource addressing in
network operating systems
.N
 8. Alison Brown (addr in networks)''','''
 .I 13
.W
 code optimization for space efficiency
.N
 13. Ralph Johnson (code opt for space)
 ''','''
 .I 20
.W
 Graph theoretic algorithms applicable to sparse matrices
.N
 20. Chanderjit Bajaj (graph alg for sparce matrices)
 ''','''.I 32
.W
 I'd like to find articles describing graph algorithms that are based on
the eigenvalue decomposition (or singular value decomposition) of the
ajacency matrix for the graph.  I'm especially interested in any heuristic
algorithms for graph coloring and graph isomorphism using this method.
.N
 32. Bengt Aspvall (graph alg / eigenvalue decomp)
 ''','''.I 41
.W
 Theory of distributed systems and databases.  Subtopics of special
interest include reliability and fault-tolerance in distributed systems,
atomicity, distributed transactions, synchronization algorithms, 
resource allocation; lower bounds and models for asynchronous parallel
systems.  Also theory of communicating processes and protocols.   
.N
 41. Michael J. Fischer, Computer Sci., Yale Univ., 10 Hillhouse Ave.,
     P.O. Box 2158 Yale Station, New Haven, Conn.  06520
 '''];


  SearchPageState(this.fileName);

  GlobalKey<FormState>formStateSearchPage=new GlobalKey<FormState>();
  bool isLoading = false;
  bool isLoading1 = false;
  TextEditingController searchText=new TextEditingController();
  final List<String> items = [
    'CISI',
    'cacm',

  ];

  String? selectedValue;
  Future<List?>evalutionSummaryData () async{

    String myurl = 'http://localhost:5000//EVALUTION';
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
  Future<void>addSearchText () async{
    String myurl = 'http://localhost:5000//WriteQuery';
    try {

      var response = await http.post(Uri.parse(myurl),
          headers: {
            'Accept': 'application/json',

          },
          body: {
            'filename':"mySearch.QRY",
            'query':searchText.text
          }
      );
      print(response.body);
    }

    catch (e) {

    }

  }
  Future<void>sendFileToProcessing (String fileName) async{


    String myurl = 'http://localhost:5000/ProcessingDataFile';
    try {

      var response = await http.post(Uri.parse(myurl),
          headers: {
            'Accept': 'application/json',

          },
          body: {
            'filename':fileName+".QRY",
          }
      );
      print(response.body);

    }

    catch (e) {

    }

  }
  Future<void>sendTextToProcessing () async{
    String myurl = 'http://localhost:5000//ProcessingQueryFile';
    try {

      var response = await http.post(Uri.parse(myurl),
          headers: {
            'Accept': 'application/json',

          },
          body: {
            'filename':"mySearch.QRY",
          }
      );
      print(response.body);
    }

    catch (e) {

    }

  }
  Future<void>sendFileToIndexing(String fileName ) async{
    String myurl = 'http://localhost:5000//IndexingQRYS';
    try {

      var response = await http.post(Uri.parse(myurl),
          headers: {
            'Accept': 'application/json',

          },
          body: {
            'filename':fileName+".QRY",
          }
      );
      print(response.body);
    }

    catch (e) {

    }

  }
  Future<void>sendTextToIndexing() async{
    String myurl = 'http://localhost:5000//IndexingQRYS';
    try {

      var response = await http.post(Uri.parse(myurl),
          headers: {
            'Accept': 'application/json',

          },
          body: {
            'filename':"mySearch.QRY",
          }
      );
      print(response.body);
    }

    catch (e) {

    }

  }
  Future<void>sendTextToMatching() async{
    String myurl = 'http://localhost:5000//Matching';
    try {

      var response = await http.post(Uri.parse(myurl),
          headers: {
            'Accept': 'application/json',

          },
          // body: {
          //   'filename':"mySearch.QRY",
          // }
      );
      print(response.body);
    }

    catch (e) {

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Form(key: formStateSearchPage,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/2.jpg"),
                  fit: BoxFit.fill)),

          child:
          Center(
              child:Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
Container( width: MediaQuery.of(context).size.width/1.5,
  height: MediaQuery.of(context).size.height/4 ,
  color: Colors.white,
  child: AutoCompleteSearchField(
style: TextStyle( overflow: TextOverflow.ellipsis,),
    controller: searchText,
    submitOnSuggestionTap: true,

    suggestions: myList,
    itemSubmitted: (dynamic  ? select) {
      setState(() {
searchText.text=select;
      });
     },
    suggestionsDirection: SuggestionsDirection.down,
    suggestionWidgetSize: 50.0,
    itemBuilder: (context, suggestion) => new Padding(
        child: new ListTile(
          title: new Text(suggestion.toString()),
        ),
        padding: const EdgeInsets.all(4.0)),
    itemFilter: (suggestion, input) =>
        suggestion!.toString().toLowerCase().contains(input.toLowerCase()),
    clearOnSubmit: false,
  decoration: InputDecoration(alignLabelWithHint: false,disabledBorder: InputBorder.none),)

  // TextFormField(
  //   controller: searchText,
  //
  //                     autocorrect: true,
  //                     maxLines: 5 ,
  //                   ),
),
                    Padding(padding: EdgeInsets.only(top: 35),),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                          //addDataset(selectedValue!);
                        });
                        print(searchText.text);
                        await addSearchText();
                        await sendTextToProcessing();
                        await sendTextToIndexing();
                        await sendTextToMatching();
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(context,  MaterialPageRoute(

                            builder: (BuildContext context) =>
                               ResultPage(searchText.text,fileName)
                        ));
                      },
                      child: (isLoading)
                          ? const SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.5,
                          ))
                          : const Text('Search'),
                    ),
                    Padding(padding: EdgeInsets.only(top: 45),),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Row(
                          children: const [
                            Icon(
                              Icons.list,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                'Select Query File',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: items
                            .map((item) =>
                            DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value as String;

                          });
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                        ),
                        iconSize: 20,
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.grey,
                        buttonHeight: 50,
                        buttonWidth: 400,
                        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.blue,
                        ),
                        buttonElevation: 2,
                        itemHeight: 40,
                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
                        dropdownMaxHeight: 200,
                        dropdownWidth: 400,
                        dropdownPadding: null,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.blue,
                        ),
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(-20, 0),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 40)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      onPressed: () async {
                        setState(() {
                          isLoading1 = true;
                        });
                        //await sendFileToProcessing(selectedValue.toString());
                        await sendFileToIndexing(selectedValue.toString());
                        await sendTextToMatching();
                        summary=await evalutionSummaryData();
                        setState(() {
                          isLoading1 = false;
                        });
                        Navigator.push(context,  MaterialPageRoute(

                            builder: (BuildContext context) =>
                               EvalutionPage(summary)
                        ));
                      },
                      child: (isLoading1)
                          ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.5,
                          ))
                          : const Text('Submit'),
                    ),
                  ])),
        )));
  }

}