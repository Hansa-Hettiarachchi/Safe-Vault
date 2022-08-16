/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_project/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com_project/content_page.dart';
import 'package:com_project/welcome-page.dart';

import 'loging_page.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();
  late Rx<User?> _user; //email, password
  FirebaseAuth auth = FirebaseAuth.instance;// use to access firebase

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges()); //user will notify
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user){
    if(user ==null){
      print("loging page");
      Get.offAll(()=>LoginPage());
    }else{
      Get.offAll(()=>ContentPage(email:user.email!));
    }
  }

  void register(String email,password) async {
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
        postDetailToFirestore();
      })

      User? user = FirebaseAuth.instance.currentUser;
      if (user!= null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      print("Account creation successful");
    }catch(e){
      Get.snackbar("About user", "message",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
            titleText: Text("Account creation failed",
            style: TextStyle(
              color: Colors.white
            ),
            ),
            messageText: Text(
              e.toString(),
              style: TextStyle(
                  color: Colors.white
              ),
            )
      );
    }

  }
  void loging(String email,password) async {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      Get.snackbar("About loging", "Loging message",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text("Loging failed",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(
                color: Colors.white
            ),
          )
      );
    }

  }
  void logout()async{
    await auth.signOut();
  }

  postDetailToFirestore() async{
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = auth.currentUser;

      Usermodel usermodel = Usermodel();

      usermodel.email = user!.email;
      usermodel.uid = user!.uid;
      usermodel.username = usernameController.text;
  }
}*/
