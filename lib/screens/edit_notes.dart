import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/screens/home_scree.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({super.key});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(
              child: Text(
            "Edit Notes",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ))),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              controller: noteController
                ..text = "${Get.arguments["note"].toString()}",
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () async{
                  FirebaseFirestore.instance.collection('notes').doc(Get.arguments["docId"].toString()).update(
                      {
                        "note" : noteController.text.trim()
                      },
                  ).then((value) => {
                    Get.offAll(() => HomeScreen()),
                   print('Data Updated')
                  });
                },
                child: Text(
                  "Update",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
