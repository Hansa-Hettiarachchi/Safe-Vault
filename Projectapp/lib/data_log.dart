import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'dart:convert';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';




class Home extends  StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Response response;
  Map <int, double> fmap = new Map() ;
  List<double> values =  [];
  List<int> ids =  [];
  List<String> strids =  [];
  List<String> strval =  [];
  Dio dio = Dio();
  String apidt = "";
  bool error = false; //for error status
  bool loading = false; //for data featching status
  String errmsg = ""; //to assing any error message from API/runtime
  var apidata; //for decoded JSON data
  var last_id;
  var id;


  @override
  initState() {
    //getData(); //fetching data
    super.initState();
  }

  Future<void> get_data() async {

    String url = "https://api.thingspeak.com/channels/1734488/fields/1.json";
    var r = await Requests.get(url);
    r.raiseForStatus();
    apidt = r.content();
    dynamic apidtjson = r.json();
    dynamic arr = apidtjson['feeds'];
    for (dynamic v in arr){
      int tempid = v['entry_id'];
      RegExp exp = RegExp(r'\d{3}.\d{2}');
      String str = v['field1'];
      //id.add()
      RegExpMatch? firstmatch = exp.firstMatch(str);
      double value = double.parse(str.substring(firstmatch!.start,firstmatch.end));
      value = value*1;

      values.add(value);
      ids.add(tempid);
      last_id = ids.last;
      //print(tempid);
      //int(value);

      for(var i = 0; i<ids.length ; i++) {
        fmap[ids[i]] = values[i];
      }
    }
    strval = values.map((e) => e.toString()).toList();
    strids = ids.map((e) => e.toString()).toList();



    // print(values);
    print(strval);

    print(" ****************************************************** ");

    print(ids.length);

    //print(strids);

    //print("  ****************************************************** ");

    // print(ids);
    //setState(() {});
    //print(apidt);


  }



  // getData() async {
  //   setState(() {
  //     loading = true;  //make loading true to show progressindicator
  //   });
  //
  //   String url = "https://api.thingspeak.com/channels/1734488/fields/1.json";
  //   //don't use "http://localhost/" use local IP or actual live URL
  //
  //   Response response = await dio.get(url);
  //   apidata = response.data; //get JSON decoded data from response
  //
  //   print(apidata); //printing the JSON recieved
  //
  //   if(response.statusCode == 200){
  //     //fetch successful
  //     if(apidata["error"]){ //Check if there is error given on JSON
  //       error = true;
  //       errmsg  = apidata["msg"]; //error message from JSON
  //     }
  //   }else{
  //     error = true;
  //     errmsg = "Error while fetching data.";
  //   }
  //
  //   loading = false;
  //   setState(() {}); //refresh UI
  // }


  @override
  Widget build(BuildContext context) {
    get_data();
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Data from REST API"),
        backgroundColor: Colors.redAccent,
      ),

      body: ListView.builder(
        itemBuilder: (BuildContext , index) {
          var val = values[index];
          var id = ids[index];
          /*return Card(
               child: ListTile(
                 leading: Text("value"),
                 title: Text(" value : "),
                 subtitle: Text(" Date and time : "),
               ),
             );*/

          return ListTile(
            title: Text("value : $val  at : $id"),
          );
        },
        itemCount: ids.length,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}





