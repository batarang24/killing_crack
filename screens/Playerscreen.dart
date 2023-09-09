import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:just_audio/just_audio.dart';
import 'package:paduka/screens/insidePlayer.dart';
import 'package:provider/provider.dart';

import '../Providers/Navigate.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState(  );
}

class _PlayerScreenState extends State<PlayerScreen> {

  bool init=true;
  @override
 
  @override
  Widget build(BuildContext context) {
  List<Map<String,dynamic>> url=[];
 List<Map<String,dynamic>>details=[];
   return StreamBuilder(
    stream: FirebaseFirestore.instance.collection('publicjokes').snapshots(),
    builder: ((context, snapshot) {
    snapshot.data?.docs.forEach((element) {
      print('OOOOOOOOOOOOOOOOOOOOOOOOOOO${element.id}');
       var a= FirebaseFirestore.instance.collection('jokes').doc(FirebaseAuth.instance.currentUser!.uid).collection('liked').doc('KxU7lLtYWmYJY0bBVxtb').get();
      // a['l']
       
      
        AudioSource audio=AudioSource.uri(Uri.parse(element['path']));
        print(audio.hashCode);
        url.add(
          {
            'id':audio.hashCode,
            'url':audio
          }
        );
        details.add(
          {
              'hash':audio.hashCode,
              'title':element['title'],
              'author':element['author'],
              'commentid':element['coid']
          }
        );
        print(url);
    
    });
     if (url.isNotEmpty) {
       return Insideplayer(
        url,
        details
      );
    }
    else
    {
          return Center(child: CircularProgressIndicator(),);
    }
   
    }),
   );
  }
}