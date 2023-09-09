import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('jokes/${FirebaseAuth.instance.currentUser!.uid}/joke').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState==ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }
        final docs=snapshot.data?.docs;
        return Scaffold(
          body: ListView.builder(
          itemCount: docs?.length,
          itemBuilder: (context, index) {
            return Container(
              child: ListTile(
                leading: Text('${index+1}'),
                title: Text(docs![index]['title']),
              ),
            );
          },
        ),
        
        );

      },
    );
  }
}