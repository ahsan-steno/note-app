import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/screens/home_scree.dart';

class CreateNotes extends StatefulWidget {
  const CreateNotes({super.key});

  @override
  State<CreateNotes> createState() => _CreateNotesState();
}

class _CreateNotesState extends State<CreateNotes> {
  TextEditingController noteController = TextEditingController();

  User? userid = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Create Note",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),backgroundColor: Colors.blue,),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(child:
              TextFormField(
                controller: noteController,
                maxLines: null,
                decoration: InputDecoration(hintText: "Add Note"),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue
              ),
              onPressed: () async{
                var note = noteController.text.trim();
                if(note != null ){
                  try{
                  await FirebaseFirestore.instance.collection("notes").doc().set({"CreatedAt" :DateTime.now(),
                   "note" : note,
                  "userId": userid!.uid,


                   });
                  }catch (e){
                 debugPrint(e.toString());
                 Get.snackbar("ErrorComes",e.toString());

                  }
                }
              }, child: GestureDetector
              (
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              },
                child: Text("Add Note",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),)
          ],
        ),
      ),
    );
  }
}
