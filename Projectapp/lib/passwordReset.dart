import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'content_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
          emailController.text = value!;
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

    return Scaffold(
      backgroundColor: Color(0xFAF3F4F6),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(" Rest Password "),
        centerTitle: true,
        toolbarHeight: 60.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20) )
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 36.0,right: 36.0,bottom: 10.0,top: 10.0),
              child: Form(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    SizedBox(height: 20),
                    const Text("Receive an Email to reset your password ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:Color(0xFF3b3f42), fontSize: 18, decoration: TextDecoration.none, fontWeight: FontWeight.bold
                      ),
                    ), Divider(thickness: 2.0,),
                    SizedBox(height: 30),
                    emailField,
                    SizedBox(height: 40),
                    Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.lightBlueAccent,
                    child: MaterialButton(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        animationDuration: Duration(seconds: 2),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          resetPassword();
                        },
                        child: const Text(
                          " Reset Password ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                     ),
                      ]
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Future resetPassword()async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ));

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim());
      SnackBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        behavior: SnackBarBehavior.floating,
        content: Text(
            "Password reset link has sent to ${emailController.text}"),
        backgroundColor: Color(0xff30a704),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch(e){
      SnackBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        behavior: SnackBarBehavior.floating,
        content: Text(e.toString()),
        backgroundColor: Color(0xff30a704),
      );
    }

  }
  
}
