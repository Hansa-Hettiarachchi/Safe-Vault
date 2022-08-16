import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_project/data_log.dart';
import 'package:com_project/model/user_model.dart';
import 'package:com_project/passivemode.dart';
import 'package:com_project/safe_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com_project/my_home_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'loging_page.dart';
import 'my_detail_page.dart';
import 'option_page.dart';
class ContentPage extends StatefulWidget {
  String email;
  ContentPage({Key? key, required this.email}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
User? user = FirebaseAuth.instance.currentUser;
Usermodel loggedin_user = Usermodel();


  List info = [];

  _readData(){
     DefaultAssetBundle.of(context).loadString("json/detail.json").then((s){
      setState(() {
        info = jsonDecode(s);
      });
    });


  }

  @override
  void initState() {
    _readData();
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value){
          this.loggedin_user = Usermodel.fromMap(value.data());
          setState(() {});
    });

    AwesomeNotifications().isNotificationAllowed().then(
          (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
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
              SizedBox(width: 55),
              Text(
                " Passive mode",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 55),
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
          child: Text(
            " Set up Your face Unlock",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );


    return Scaffold(
      backgroundColor: Color(0xFADED9F8),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(" Safe Vault "),
        centerTitle: true,
        toolbarHeight: 60.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20) )
        ),
        actions:<Widget> [
            IconButton(
            icon: Icon(Icons.exit_to_app_rounded),
            onPressed: (){
              logout(context);
            },
            ),
        ],
      ),

      body: Center(
        child: Container(
          padding: const EdgeInsets.only( top:55),
          color:Color(0xFADED9F8),
          child: Column(
            children: [
              // user name and id box
              Container(
                width: width,
                height: 100,
                margin: const EdgeInsets.only(left: 25, right: 30),
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
                                fontSize: 18,
                                decoration: TextDecoration.none
                            ),
                          ),
                          Text(
                            "User id : ${loggedin_user.uid}",
                            style: TextStyle(
                                color:Color(0xFF3b3f42),
                                fontSize: 18,
                                decoration: TextDecoration.none
                            ),
                          ),
                          SizedBox(height: 5,),
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:Color(0xFFf3fafc)
                        ),
                        child: Center(
                          child: GestureDetector(

                            onTap: (){
                              Get.to(() => const OptionPage());
                            },
                            child: Icon(
                              Icons.settings,
                              /*color:Color(0xFF69c5df),*/
                              color: Colors.black87,
                              size: 30,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),

              //My options box
              /*Container(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  children: [
                    Text(
                      " My options",
                      style: TextStyle(
                          color:Color(0xFF1f2326),
                          fontSize: 20,
                          decoration: TextDecoration.none
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),*/
              Divider(thickness: 2.0,),
              SizedBox(height: 40,),

              //safe access log box
              Container(
                height: 150,
                child: PageView.builder(
                    controller: PageController(viewportFraction: 0.88),
                    itemCount: 1,
                    itemBuilder: (_, i){
                      return GestureDetector(
                        onTap: (){
                          Get.to(()=> const DetailPage());
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          height: 150,
                          width: MediaQuery.of(context).size.width-20,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color:i.isEven?Color(0xFF69c5df):Color(0xFF9294cc)
                          ),
                          child: Column(
                            children: [
                              Container(
                                  child:Row(
                                    children: [
                                      Text(info[i]['title'],
                                        //Text('title',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500,
                                            color:Colors.white
                                        ),
                                      ),
                                      Expanded(child: Container())
                                    ],
                                  )
                              ),
                              Divider(thickness: 1.0,),
                              Container(
                                width: width,
                                child: Text(info[i]["text"],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:Color(0xFFb8eefc)
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,),

                            ],
                          ),
                        ),
                      );
                    }),
              ),

              SizedBox(height: 20,),

              //safe function box
              Container(
                height: 150,
                child: PageView.builder(
                    controller: PageController(viewportFraction: 0.88),
                    itemCount: 1,
                    itemBuilder: (_, i){
                      return GestureDetector(
                        onTap: (){
                          Get.to(()=> SafeFunctions(email: '',));
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          height: 150,
                          width: MediaQuery.of(context).size.width-20,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color:Color(0xFF9294cc),
                          ),
                          child: Column(
                            children: [
                              Container(
                                  child:Row(
                                    children: [
                                      Text('Safe vault functions',
                                        //Text('title',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w500,
                                            color:Colors.white
                                        ),
                                      ),
                                      Expanded(child: Container())
                                    ],
                                  )
                              ),
                              Divider(thickness: 1.0,),
                              Container(
                                width: width,
                                child: Text("Activate safe vault security functions",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:Color(0xFFb8eefc)
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,),

                            ],
                          ),
                        ),
                      );
                    }),
              ),

               //recent contests
              SizedBox(height: 20,),

              // face select and passive mode buttons
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 26.0,right: 36.0,bottom: 10.0,top: 10.0),
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //faceSelectbutton,
                          SizedBox(height: 20,),
                          passiveModebutton,
                        ]
                      )
                    )
                )
              )

            ],
          ),
        ),
      ),
    );


  }
// the logout function
Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()));
}
}
