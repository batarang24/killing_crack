import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
class Record
{
 
   void startRecord(String name) async {
 
    bool hasPermission = await checkPermission();
    
    if (hasPermission) {
     

      var recordFilePath = '/data/user/0/com.example.paduka/app_flutter/audiofile';
      

      RecordMp3.instance.start(recordFilePath, (type) {
       
      });
     
    } 
    
  }

  
  void stopRecord(String name,BuildContext context) async{
    String uri='';
   
   
    bool s = RecordMp3.instance.stop();
    Navigator.of(context).pushNamed(
      'dataitems',
      arguments: {
        'file':'/data/user/0/com.example.paduka/app_flutter/audiofile'
      }
    );
   
   // final ref=FirebaseStorage.instance.ref().child('jokes').child('dialouges').child(name);
     //await ref.putFile(File('/data/user/0/com.example.paduka/app_flutter/audiofile'));
 
  }



 
 Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      PermissionStatus status2=await Permission.storage.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }
}