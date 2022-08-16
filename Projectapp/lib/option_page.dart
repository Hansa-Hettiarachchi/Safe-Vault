import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_project/extra/change_password.dart';
import 'package:com_project/passwordReset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com_project/model/user_model.dart';

import 'content_page.dart';
import 'loging_page.dart';




class OptionPage extends StatefulWidget {
  const OptionPage({Key? key}) : super(key: key);

  @override
  _OptionPageState createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
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
    final usernameController = new TextEditingController();
    final usermobileNOController = new TextEditingController();
    final emailEditingController = new TextEditingController();
    final newPasswordEditingController = new TextEditingController();
    final confirmNewPasswordEditingController = new TextEditingController();
    final previousPasswordEditingController = new TextEditingController();

    final userNameField = TextFormField(
        autofocus: false,
        controller: usernameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("User Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid User name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          usernameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "User Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

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

    //mobile no field
    final mobileNumber = TextFormField(
        autofocus: false,
        controller: usermobileNOController,
       // keyboardType: TextInputType.number,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{10,}$');
          if (value!.isEmpty) {
            return ("mobile number is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid mobile number(Min. 10 Character)");
          }
        },
        onSaved: (value) {
          usermobileNOController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone_android),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Mobile number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //previous password field
    final previousPasswordField = TextFormField(
        autofocus: false,
        controller: previousPasswordEditingController,
        obscureText: true,
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
          previousPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Enter your password ",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    void updateData() async{
      try {
        final docUs = FirebaseFirestore.instance.collection('users').doc(
            user?.uid);
        docUs.update({
          'username': '${usernameController.text}',
          'mobileNo': '${usermobileNOController.text}'
        });
        var snackBar = SnackBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          behavior: SnackBarBehavior.floating,
          content: Text("Your information updated successfully"),
          backgroundColor: const Color(0xff30a704),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(builder: (context) => OptionPage()),
                (route) => false);
      } catch (e){
        var snackBar = SnackBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString()),
          backgroundColor: const Color(0xffe76211),
        );
      }
    }

    final updatebutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.lightBlueAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          animationDuration: Duration(seconds: 2),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            updateData();
          },
          child: Text(
            " update ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    final changePasswordButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blueAccent,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          animationDuration: Duration(seconds: 2),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Get.to(()=> ForgotPasswordPage());
          },
          child: Text(
            " Change Password ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    final deactivatebutton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.red,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          animationDuration: Duration(seconds: 2),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            logout(context);
          },
          child: Text(
            " Sign out ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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
      body:Center(
        child: SingleChildScrollView(
          child: Container(
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
                                 SizedBox(height: 20),
                                 Text(
                                   "Update your info Here ",
                                   style: TextStyle(
                                       color:Color(0xFF3b3f42),
                                       fontSize: 18,
                                       decoration: TextDecoration.none
                                   ),
                                 ),
                                 SizedBox(height: 20),
                                 userNameField,
                                 SizedBox(height: 20),
                                 emailField,
                                 SizedBox(height: 20),
                                 mobileNumber,
                                 SizedBox(height: 20),
                                 previousPasswordField,
                                 SizedBox(height: 30),
                                 updatebutton,
                                 SizedBox(height: 30),
                                 changePasswordButton,
                                 SizedBox(height: 45),
                                 deactivatebutton,
                               ]
                           )
                       )
                   )
               )
             ],
           ),
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

