import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/screens/Forgot%20Password.dart';
import 'package:notes_app/screens/Signup.dart';
import 'package:firebase_auth_platform_interface/src/firebase_auth_exception.dart';
import 'package:notes_app/screens/home_scree.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

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
   controller: loginEmailController,
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
                  controller: loginPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: Icon(Icons.visibility_off_outlined),
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword() ));
                },
                child: Container(

                    child: Padding(
                      padding:  EdgeInsets.only(right:190),
                      child: Text('Forgot Password'),
                    )),
              ),
              SizedBox(height: 40,),
              ElevatedButton(

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(150, 50)
              ),
                  onPressed: () async{
               var loginEmail = loginEmailController.text.trim();
               var loginPassword = loginPasswordController.text.trim();

               try{
                 final User? firebaseUser = (await FirebaseAuth.instance.signInWithEmailAndPassword(
                     email: loginEmail,
                     password: loginPassword)).user;
                 if(
                 firebaseUser != null) {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                 } else {
                   print("Check Email and password");
                 }
               }on FirebaseAuthException catch (e){
                 print('Error $e');
               }
                  },
                  child: ( Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),))),
              SizedBox(height: 10,),

              Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(child: Text("Don't have an account ?"),),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                        },
                        child: Container(
                          child: Text(
                            'Sign Up',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                        ),
                      )
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
