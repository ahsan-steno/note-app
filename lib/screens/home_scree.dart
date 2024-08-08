import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:notes_app/screens/create_notes.dart';
import 'package:notes_app/screens/edit_notes.dart';
import 'package:notes_app/screens/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Icon (Icons.logout_outlined,color: Colors.white,))
        ],
        title: Center(child: Text("Home Screen",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),backgroundColor: Colors.blue,),
      body: Container(
        child: StreamBuilder(stream: FirebaseFirestore.instance.collection("notes").where("userId", isEqualTo: userId!.uid).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return Text("Something went wrong");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
            child: CupertinoActivityIndicator(),
            );

          }
          if(snapshot.data!.docs.isEmpty){
            return Center(child: Text("No Data Found"));
          }
          if(snapshot != null && snapshot.data != null){
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  var note = snapshot.data!.docs[index]["note"];
                  var noteId = snapshot.data!.docs[index]["userId"];
                  var docId = snapshot.data!.docs[index].id;
                  return Card(
                child: ListTile(
                  title: Text(note),
                  subtitle: Text(noteId),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                          onTap: (){
                           print(noteId);
                         Get.to(() => EditNotes(),
                          arguments: {
                            "note" : note,
                             "docId" : docId,
                          }
                          );



                          },
                          child: Icon(Icons.edit)),
                     SizedBox(width: 10.0,),
                      GestureDetector(
                          onTap: ()async{
                          await  FirebaseFirestore.instance.collection("notes").doc(docId).delete();
                          },
                          child: Icon(Icons.delete))
                    ],
                  ),
                ),
              );
            });
          }
          return CircularProgressIndicator();
          },),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNotes()));
      },child: Icon(Icons.add),),

    );
  }
}
