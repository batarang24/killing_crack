import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paduka/Providers/Navigate.dart';
import 'package:paduka/modals/Record.dart';
import 'package:paduka/screens/Likedscreen.dart';
import 'package:paduka/screens/Myjokes.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../widgets/Tiles.dart';

class Profile extends StatefulWidget {
  String username;
  Profile(this.username);


  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   var uuid=Uuid();  

  bool stop=false;

  Record rec=new Record();

  void record()
  {
    rec.startRecord(uuid.v1());
  }

  void stoper(BuildContext ctx,BuildContext boolcontext)
  {
     Navigator.pop(boolcontext);
    rec.stopRecord(uuid.v1(),ctx);
  }
  void popup(BuildContext ctx)
  {
    showDialog(context: ctx,barrierDismissible: false, builder: (context){
      bool stoop=false;
      var boolcontext=context;
      return StatefulBuilder(
        builder: (context, setState) {
            return AlertDialog(
      
        backgroundColor: Colors.transparent,
        content: Container(
          color: Colors.transparent,
          height: 100,
          width: 100,
            child: ElevatedButton(
            
           child:Icon(!stop?Icons.mic:Icons.stop,size: 45,color: Colors.black,),
            onPressed:!stop ?(){
                record();
                setState(() {
                  stop=!stop;
                },);
            }:(){
              stoper(context,boolcontext);
              setState(() {
                stop=!stop;
              },);
            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: !stop?Color.fromARGB(255, 82, 154, 84):Color.fromARGB(255, 252, 76, 64)
            ),
          ),
        ),
      );
        },
      );
    });
  }
   void upload(BuildContext ctx) async{
    String genre="dialouges";
    FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['mp3'],
    );
    if (result!=null) {
      File file=File(result.files.single.path!);

      print(file.path);
      Navigator.of(ctx).pushNamed(
        'dataitems',
        arguments: {
          'file':file.path,
          
        }
      );

      /**/
    }
  }

  
  @override
  Widget build(BuildContext context) {
   void toliked(){
    Navigator.of(context).pushNamed(
      'Liked'
    );
   }
  void library()
  {
    Navigator.of(context).pushNamed(
      'Myjokes'
    );
  }
    
    return WillPopScope(
      onWillPop: ()async=>false,
      child:  Scaffold(
       
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
         decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 77, 77, 77),Color.fromARGB(255, 43, 43, 43), Colors.black])),
        //color: Colors.black,
        child: Column(

          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              //padding: EdgeInsets.all(),
            
                child: Container(
                  height: 350 ,
                  width: MediaQuery.of(context).size.width,
              

                  child: Container(
                    margin: EdgeInsets.only(top:40),
                    decoration: BoxDecoration(
                      
                    ),
                    child: Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  
                   CircleAvatar(
                    //backgroundColor: Colors.green,
                    backgroundImage: AssetImage('assets/img.png'),
                    backgroundColor: Colors.green,
                    radius: 80,
                    ),
                    SizedBox(height: 10),
                    Text(widget.username,style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold,fontSize: 22),),
                    SizedBox(height: 10,),
                    FittedBox(
                      child: Text('Total laughs : 10',style: TextStyle(color: Color.fromARGB(255, 162, 162, 162),fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                       /* ElevatedButton(onPressed: !stop?record:stoper, child: Text(!stop?'Record':'Stop')),
                        ElevatedButton(onPressed: ()=>upload(context), child: Text('Upload'))*/
                        OutlinedButton(onPressed:()=>popup(context), child: Text('Record',style: TextStyle(color: Colors.white),),style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                          side: BorderSide(color: Colors.grey)
                        )),
                         OutlinedButton(onPressed:()=>upload(context), child: Text('Upload',style: TextStyle(color: Colors.white),),style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                          side: BorderSide(color: Colors.grey)
                        ))
                    
                      ],
                    )
                    
                    ],
                  ),
                  ),
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                   // color: Colors.black
                  ),
                ),
              
              
            ),
            Divider(),
         
            Container(
              height: 300,
              child:Column(
                children: [
                  Tiles('My Jokes',Icons.headphones,library),
                  Tiles('Liked Jokes',Icons.favorite,toliked)
                ],
              )

            )
            

          
          ],
        ),
      ),
       bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: Provider.of<Navigate>(context).currentindex,
        onTap: ((value) {
          print(value);
          switch (value) {
            case 0: Navigator.of(context).pushNamed('Profile');
                    break;

            case 1:Navigator.of(context).pushNamed('Player');
                  break;
            
            case 2:Navigator.of(context).pushNamed('Trend');
                  break;
            
          }
          Provider.of<Navigate>(context,listen: false).changeindex(value);
        }),
        backgroundColor: Color.fromARGB(255, 43, 43, 43),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.white,),
            label: 'Home'
            
          ),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow_sharp,color: Colors.white,),label: 'Play'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up,color: Colors.white,),label: 'Trending')
        ],
       ),
    ),
    );
  }
}