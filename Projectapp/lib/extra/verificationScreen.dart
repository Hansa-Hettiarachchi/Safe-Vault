import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_project/loging_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/user_model.dart';

class VerificationScreen extends StatefulWidget {
  String email;
  VerificationScreen({Key? key,required this.email}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  Usermodel loggedin_user = Usermodel();

  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then((value){
      this.loggedin_user = Usermodel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    //verification button
    final verifyButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightBlueAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
              try {
                final user = FirebaseAuth.instance.currentUser;
                    if (user!.emailVerified) {
                      var snackBar3 = const SnackBar(
                        shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.all(Radius.circular(15))),
                        behavior: SnackBarBehavior.floating,
                        content: Text("Your email has verified!"),
                        backgroundColor: Color(0xff30a704),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar3);
                      Get.to(() => LoginScreen());
                    } else {
                      var snackBar3 = const SnackBar(
                        shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.all(Radius.circular(15))),
                        behavior: SnackBarBehavior.floating,
                        content: Text("Warning! : Your email is not verified. Email is sent to your account. Make sure to verify your email."),
                        backgroundColor: Color(0xffe76211),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar3);
                    }
              } catch (e) {
                var snackBar2 = SnackBar(
                  shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
                  behavior: SnackBarBehavior.floating,
                  content: Text(e.toString()),
                    backgroundColor: const Color(0xfffa4e4e),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar2);
              }
          },
          child: Text(
            "Verify Email",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(" Safe Vault Verification "),
        centerTitle: true,
        toolbarHeight: 60.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20) )
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
                child: Padding(
                    padding: const EdgeInsets.only(left: 36.0,right: 36.0,bottom: 10.0,top: 10.0),
                    child: Form(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              Text(
                                "User id : ${loggedin_user.uid}",
                                style: TextStyle(
                                  color:Color(0xFF3b3f42),
                                  fontSize: 18,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Divider(thickness: 2.0,),
                              SizedBox(height: 20),
                              Text(
                                "verify your identity ",
                                style: TextStyle(
                                    color:Color(0xFF3b3f42),
                                    fontSize: 18,
                                    decoration: TextDecoration.none
                                ),
                              ),
                              SizedBox(height: 20),
                              SizedBox(height: 40),
                              SizedBox(height: 85),
                              verifyButton,
                            ]
                        )
                    )
                )
            )
          ],
        ),
      ),

    );
  }
}
