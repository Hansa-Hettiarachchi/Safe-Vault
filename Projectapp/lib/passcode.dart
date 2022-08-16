import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_project/safe_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:firebase_database/firebase_database.dart';

import 'model/user_model.dart';

class PasscodePage extends StatefulWidget {

  const PasscodePage({Key? key}) : super(key: key);


  @override
  _PasscodePageState createState() => _PasscodePageState();
}

class _PasscodePageState extends State<PasscodePage> {

final fb = FirebaseDatabase.instance;
DatabaseReference ref1 = FirebaseDatabase.instance.ref();

  User? user = FirebaseAuth.instance.currentUser;
  Usermodel loggedInUser = Usermodel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = Usermodel.fromMap(value.data());
      setState(() {});
    });
  }


  //DatabaseReference ref = FirebaseDatabase.instance.ref("User");
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    //passcode editing controller
    final newPasscodeEditingController = new TextEditingController();
    final confirmNewPasscodeEditingController = new TextEditingController();

    //New passcode field
    final newPasscodeField = TextFormField(
        autofocus: false,
        controller: newPasscodeEditingController,
        obscureText: true,
        keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for update");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          newPasscodeEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter Safe vault passcode ",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //New passcode field
    final newPasscodeConfirmField = TextFormField(
        autofocus: false,
        controller: confirmNewPasscodeEditingController,
        obscureText: true,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (confirmNewPasscodeEditingController.text !=
              newPasscodeEditingController.text) {
            return "Password don't match";
          }
          else {
            return value;}
        },
        onSaved: (value) {
          confirmNewPasscodeEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Safe vault passcode ",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );



    final ref = fb.ref().child('${loggedInUser.uid}').child("Passcode");

    void setupData() {
      if(confirmNewPasscodeEditingController.text ==
          newPasscodeEditingController.text){
        try {
          ref.set(confirmNewPasscodeEditingController.text);
          var snackBar = SnackBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            behavior: SnackBarBehavior.floating,
            content: Text("Your safe passcode setup successfully"),
            backgroundColor: const Color(0xff30a704),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushAndRemoveUntil(
              (context),
              MaterialPageRoute(builder: (context) => PasscodePage()),
                  (route) => false);
        }catch(e){
          var snackBar = SnackBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            behavior: SnackBarBehavior.floating,
            content: Text(e.toString()),
            backgroundColor: const Color(0xffe76211),
          );
        }
      }else{
        var snackBar = SnackBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          behavior: SnackBarBehavior.floating,
          content: Text("passcode does not match"),
          backgroundColor: const Color(0xffe76211),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    final setupbutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightBlueAccent,
      child: MaterialButton(

          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          animationDuration: Duration(seconds: 2),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            setupData();
          },
          child: Row(
            children: [
              SizedBox(width: 20),
              Icon(Icons.lock),
              SizedBox(width: 40),
              Text(
                " Setup Passcode ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );





    return Scaffold(
      backgroundColor: Color(0xFFc5e5f3),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Get.to(() => SafeFunctions(email: '',));
          },
        ),
        title: Text(" Setting up safe vault passcode "),
        centerTitle: true,
        toolbarHeight: 60.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20) )
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 36.0,right: 36.0,bottom: 200.0,top: 1.0),
                  child: Form(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "User id : ${loggedInUser.uid}",
                              style: TextStyle(
                                color:Color(0xFF3b3f42),
                                fontSize: 18,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(thickness: 2.0,),
                            SizedBox(height: 50),
                            Text(
                              "Enter safe vault Passcode here ",
                              style: TextStyle(
                                  color:Color(0xFF3b3f42),
                                  fontSize: 18,
                                  decoration: TextDecoration.none
                              ),
                            ),
                            SizedBox(height: 30),
                            newPasscodeField,
                            SizedBox(height: 20),
                            newPasscodeConfirmField,
                            SizedBox(height: 80),
                            setupbutton,
                          ]
                      )
                  )
              )
            ],
          ),
        ),
      ),
    );
  }


}
