import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_project/option_page.dart';
import 'package:com_project/passwordReset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/user_model.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

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

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    // string for displaying the error Message
    String? errorMessage;

    // our form key
    final _formKey = GlobalKey<FormState>();

    // editing Controller
    final emailEditingController = new TextEditingController();
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final changePasswordButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          animationDuration: Duration(seconds: 2),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Get.to(() => ForgotPasswordPage());
          },
          child: Text(
            " Change Password ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Color(0xFAF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Get.to(() => OptionPage());
          },
        ),
        title: Text(" Safe Vault "),
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
                              SizedBox(height: 10),
                              Text(
                                "Update your Password Here ",
                                style: TextStyle(
                                    color:Color(0xFF3b3f42),
                                    fontSize: 18,
                                    decoration: TextDecoration.none
                                ),
                              ),

                              SizedBox(height: 20),
                              emailField,
                              SizedBox(height: 50),
                              changePasswordButton,

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

