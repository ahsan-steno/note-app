


import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/screens/home_scree.dart';
import 'package:notes_app/screens/login.dart';
import 'package:notes_app/services/signup_services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //  Icon(Icons.more_vert)
        // ],
        title: Center(child: Text('Sign Up Screen',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
              children: [

                Container(
                  alignment: Alignment.center,
                  height: 250,
                  width: 200,
                  child: Lottie.asset('assets/Animation - 1719639056767 (1).json'),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                          controller: userNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      hintText: 'User Name',
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
 controller: userPhoneController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_outlined),

                      hintText: 'Phone Number',
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
controller: userEmailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),

                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
controller: userPasswordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: Icon(Icons.visibility_off_outlined),
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(

                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(150, 50)
                    ),
                    onPressed: () async{
                    var userName = userNameController.text.trim();
                    var userPhone = userPhoneController.text.trim();
                    var userEmail = userEmailController.text.trim();
                    var userPassword = userPasswordController.text.trim();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
           email: userEmail,
           password: userPassword).then((Value)=> {

             log("user Created"),
        signupUser(userName,
        userPhone,
        userEmail,
        userPassword
        ),
           });

                    },
                    child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        child: ( Text('Sign Up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)))),
                SizedBox(height: 10,),

                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(child: Text("Already have an account ?"),),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child: Container(child: Text('Login',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 15),)))
                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}

