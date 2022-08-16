import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_project/passcode.dart';
import 'package:com_project/passivemode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import 'content_page.dart';
import 'model/user_model.dart';
import 'option_page.dart';

class SafeFunctions extends StatefulWidget {
  String email;
  SafeFunctions({Key? key, required this.email}) : super(key: key);

  @override
  _SafeFunctionsState createState() => _SafeFunctionsState();
}

class _SafeFunctionsState extends State<SafeFunctions> {

  User? user = FirebaseAuth.instance.currentUser;
  Usermodel loggedin_user = Usermodel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedin_user = Usermodel.fromMap(value.data());
      setState(() {});
    });
  }


    @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    int _currentIndex  = 0;

    final passiveModebutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.red,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          animationDuration: Duration(seconds: 2),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Get.to(() =>Passivemode());
          },
          child: Row(
            children: [
              SizedBox(width: 20),
              Icon(Icons.warning_amber_rounded,color: Colors.white,),
              SizedBox(width: 50),
              Text(
                " Passive mode",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 50),
              Icon(Icons.warning_amber_rounded,color: Colors.white,),
            ],
          )),
    );


    final faceSelectbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          animationDuration: Duration(seconds: 2),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            var url = Uri.parse('http://192.168.1.9');

            if(await canLaunchUrl(url)){
              await launchUrl(
                url, mode: LaunchMode.inAppWebView,
              );
            }else{
              throw 'Could not launch $url';
            }
          },
          child: Row(
            children: [
              SizedBox(width: 20),
              Icon(Icons.face_outlined,color: Colors.white,),
              SizedBox(width: 20),
              Text(
                " Set up Your face Unlock",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );

    final passcodeSelectbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          animationDuration: Duration(seconds: 2),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: (){
            Get.to(PasscodePage());
          },
          child: Row(
            children: [
              SizedBox(width: 20),
              Icon(Icons.lock,color: Colors.white,),
              SizedBox(width: 20),
              Text(
                " Set up Your safe Passcode",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );


    return Scaffold(
      backgroundColor: Color(0xFADED9F8),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
           Get.to(() => ContentPage(email: '',));

          },
        ),
        title: Text(" Safe Vault "),
        centerTitle: true,
        toolbarHeight: 60.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20) )
        ),
      ),

      body: Center(
        child: Container(
          padding: const EdgeInsets.only( top:55),
          color:Color(0xFADED9F8),
          child: Column(
            children: [
              // face select and passive mode buttons
              Center(
                child: Container(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 26.0,right: 36.0,bottom: 10.0,top: 10.0),
                        child: Form(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  //username box
                                  Container  (
                                    width: width,
                                    height: 100,
                                    margin: const EdgeInsets.only(left: 0, right: 0),
                                    // padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:Color(0xFFebf8fd),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child: Row(
                                        children: [
                                          /* CircleAvatar(
                                                radius:40,
                                                  backgroundImage: AssetImage("img/background.jpg"),
                                              ),*/
                                          SizedBox(width: 5,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "User name : ${loggedin_user.username}",
                                                style: TextStyle(
                                                    color:Color(0xFF3b3f42),
                                                    fontSize: 22,
                                                    decoration: TextDecoration.none
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                              Text(
                                                "User id : ${loggedin_user.uid}",
                                                style: TextStyle(
                                                    color:Color(0xFF3b3f42),
                                                    fontSize: 22,
                                                    decoration: TextDecoration.none
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Divider(thickness: 3.0,),
                                  SizedBox(height: 40,),
                                  faceSelectbutton,
                                  SizedBox(height: 30,),
                                  passcodeSelectbutton,
                                  SizedBox(height: 30,),
                                  passiveModebutton,
                                ]
                            )
                        )
                    )
                ),
              )
            ],

          ),
        ),
      ),
    );
  }

}
