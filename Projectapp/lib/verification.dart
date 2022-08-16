import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loging_page.dart';

class verifyEmail extends StatefulWidget {
  const verifyEmail({Key? key}) : super(key: key);

  @override
  _verifyEmailState createState() => _verifyEmailState();
}

class _verifyEmailState extends State<verifyEmail> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
          (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose(){
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async{
    //call email verification
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerified){
      timer?.cancel();
    }
  }


  Future sendVerificationEmail() async{
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);

    }catch (e){
      var snackBar = SnackBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        behavior: SnackBarBehavior.floating,
        content: Text(e.toString()),
        backgroundColor: const Color(0xfffa4e4e),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
    ? LoginScreen()
      : Scaffold(
    backgroundColor: Color(0xFAF3F4F6),
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text(" Safe Vault Verification "),
            centerTitle: true,
            toolbarHeight: 60.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20) )
            ),
          ),
    body:Container(
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

                            Text(" A verification Email Has been Sent ",
                              style: TextStyle(
                                color:Color(0xFF3b3f42),
                                fontSize: 18,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(thickness: 2.0,),
                            SizedBox(height: 20),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.lightBlueAccent,
                              child: MaterialButton(
                                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                  //minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () {
                                    canResendEmail ? sendVerificationEmail : null;
                                  },
                                  child: Text(
                                    "Resend Verification Email",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                  )),
                            ),
                            SizedBox(height: 20),
                            SizedBox(height: 40),
                            SizedBox(height: 85),
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
