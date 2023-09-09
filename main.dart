import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paduka/Providers/Navigate.dart';

import 'package:paduka/screens/Likedscreen.dart';
import 'package:paduka/screens/Myjokes.dart';
import 'package:paduka/screens/Playerscreen.dart';
import 'package:paduka/screens/Profile.dart';
import 'package:paduka/screens/Trend.dart';
import 'package:provider/provider.dart';

import './screens/AuthScreen.dart';
import './screens/DataCollector.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './screens/Flag.dart';
import 'package:just_audio/just_audio.dart';


void main(List<String> args) async{
 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 bool newer =false;

/*final player=AudioPlayer();
final playlist = ConcatenatingAudioSource(
  
  useLazyPreparation: true,
  children: [
    AudioSource.uri(Uri.parse('https://firebasestorage.googleapis.com/v0/b/paddu-3acfa.appspot.com/o/downloaded%2FAdichithooku.mp3?alt=media&token=8695cbb3-37c9-42c9-bc48-2bbc20ccbdcd')),
    AudioSource.uri(Uri.parse('https://firebasestorage.googleapis.com/v0/b/paddu-3acfa.appspot.com/o/downloaded%2FMayanadhi.mp3?alt=media&token=e0154b1b-6170-4a60-9e2c-7b19736fe988')),
    AudioSource.uri(Uri.parse('https://firebasestorage.googleapis.com/v0/b/paddu-3acfa.appspot.com/o/downloaded%2FThendral%20vanthu.mp3?alt=media&token=b208199e-a625-4422-8d3f-5461e47db030')),
  ],
);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: IconButton(
              icon: Icon(Icons.play_circle),
              onPressed: () async{
                await player.setAudioSource(playlist, initialIndex: 0, initialPosition: Duration.zero);
                player.play();
              },
            ),
          ),
        ),
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    late String user;
    
    return WillPopScope(
      onWillPop: ()async=>false,
      child: ChangeNotifierProvider(
      create: (context) => Navigate(),
      child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              var uid=snapshot.data!.uid;
              return StreamBuilder(
                stream:  FirebaseFirestore.instance.collection('jokes').doc(FirebaseAuth.instance.currentUser!.uid).collection('taste').snapshots(),
                
                builder: (context, snapshot) {
                   
                  final len=snapshot.data?.docs.length;
                Future.delayed(const Duration(seconds: 2));
                 print(len);
                  if (len!=0) {
                    
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
                      builder: ((context, snapshot) {
                        Future.delayed(const Duration(seconds: 2));
                        if (snapshot.hasData) {
                          final username=snapshot.data?.get('username');
                          user=username;
                            return Profile(username);
                        }
                        return Center();
                    
                      
                      }),
                    );
                  }
                  else
                  {
                    return Flag();
                  }
                },
              );
            }
            else
            {
              return AuthScreen();
            }
          },
        ),
      
      ),
      routes: {
       
        'dataitems':(context)=>DataCollector(),
        'Profile':(context) => Profile(user),
        'Flag':(context) => Flag(),
        'Liked':(context) => Liked(),
        'Myjokes':(context) => Myjokes(),
        'Trend':(context)=>Trend(),
        'Player':(context) => PlayerScreen()
      },
      
    ),
      
    ),
    );
    
  }
}