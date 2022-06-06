import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ir_project/searchPage.dart';
import 'package:auto_complete_search/auto_complete_search.dart';
class SelectDataFile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SelectDataFileState();
  }

}
class SelectDataFileState extends State<SelectDataFile>{
  final List<String> items = [
    'CISI',
    'cacm',

  ];

  String? selectedValue;
  bool isLoading = false;
  Future<void>addDataset (String fileName) async{


      String myurl = 'http://localhost:5000/ProcessingDataFile';
      try {

        var response = await http.post(Uri.parse(myurl),
            headers: {
              'Accept': 'application/json',

            },
            body: {
              'filename':fileName+".txt",
            }
        );
        print(response.body);

      }

      catch (e) {

      }

  }

  Future<void>sendDataToIndexing(String fileName) async{
    String myurl = 'http://localhost:5000//IndexingDOC';
    try {

      var response = await http.post(Uri.parse(myurl),
          headers: {
            'Accept': 'application/json',

          },
          body: {
            'filename':fileName+".txt",
          }
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
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/1.jpg"),
                fit: BoxFit.fill)),

      child:
      Center(
        child:Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [

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
                    'Select Dataset',
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
              isLoading = true;
            });
            // await addDataset(selectedValue!);
             await sendDataToIndexing(selectedValue!);
            setState(() {
              isLoading = false;
            });
            Navigator.push(context,  MaterialPageRoute(

                builder: (BuildContext context) =>
                   SearchPage(selectedValue)
            ));
          },
          child: (isLoading)
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
    ));
  }

}