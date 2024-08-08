import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/screens/Signup.dart';
import 'package:notes_app/screens/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController forgetpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //  Icon(Icons.more_vert)
        // ],
        title: Center(child: Center(child: Text('Login Screen',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
              children: [

                Container(
                  alignment: Alignment.center,
                  height: 350,
                  width: 200,
                  child: Lottie.asset('assets/Animation - 1719639056767 (1).json'),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                   controller: forgetpasswordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                ElevatedButton(

                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(150, 50)
                    ),
                    onPressed: () async{
                      var forgotEmail = forgetpasswordController.text.trim();
                      try{
                        FirebaseAuth.instance.sendPasswordResetEmail(email: forgotEmail).
                        then((Value) => {print("Email Send!"),
                        Navigator.push(context, MaterialPageRoute(builder: (context)  => LoginScreen()))
                        });
                      }on FirebaseAuthException catch (e){
                        print("Errer $e");
                      }
                    },
                    child: ( Text('Forgot Password',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),))),
              ],
            )
        ),
      ),
    );
  }
}
