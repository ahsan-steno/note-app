import 'package:get/get.dart';
import 'package:get/get_connect.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notes_app/screens/login.dart';


signupUser(String userName,
           String userPhone,
           String userEmail,
            String userPassword,) async{
  User? userid = FirebaseAuth.instance.currentUser;

  try {

    await FirebaseFirestore.instance.collection("users").doc().set({
      "userName":userName,
      "userPhone":userPhone,
      "userEmail":userEmail,
      "userPassword":userPassword,
  }).then((value) => {
    FirebaseAuth.instance.signOut(),
 Get.to(() => LoginScreen() )
    });
  } on FirebaseAuthException catch (e){
    print("Error $e");
  }



}

class Go {
}