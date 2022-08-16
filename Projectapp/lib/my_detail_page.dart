import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'dart:convert';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:get/get.dart';

import 'content_page.dart';
import 'my_home_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.pop(context);
          },
          ),
          title: Text("My Bot"),
          centerTitle: true,
          toolbarHeight: 60.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20) )
          ),
        ),
        body: Container(
          child: Text("detail page"),
        )
          );
  }
}
