/*
import 'package:flutter/material.dart';
import 'package:com_project/auth_controller.dart';

class WelcomePage extends StatelessWidget {
  String email;
  WelcomePage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFAF3F4F6),
      body: Column(
        children: [
          */
/*Container(
            width: w,
            height: h*0.3,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/background.jpg"
                    ),
                    fit: BoxFit.cover
                )
            ),
            child: Column(
              children: [
                SizedBox(height: h*0.14,),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 62,
                  backgroundImage: AssetImage("img/3.png"),
                ),
              ],
            ),
          ),*//*

          */
/*SizedBox(height: 60,),
          Container(
            width: w,
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome",
                  style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                ),
                Text(email,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey
                  ),
                ),
              ],
            ),
          ),*//*

          */
/*SizedBox(height: 150,),*//*

          GestureDetector(
            onTap: (){
              AuthController.instance.logout();
            },
            child: Container(
              width: w*0.5,
              height: h*0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: AssetImage("img/1.jpg"
                      ),
                      fit: BoxFit.cover
                  )
              ),
              child: Center(
                child: Text("Sign Out",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );;
  }
}
*/
