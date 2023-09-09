import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'package:select_form_field/select_form_field.dart';
import 'package:uuid/uuid.dart';

import '../Providers/Navigate.dart';

class DataCollector extends StatefulWidget {
  const DataCollector({super.key});

  @override
  State<DataCollector> createState() => _DataCollectorState();
}

class _DataCollectorState extends State<DataCollector> {

  late String title;
  late String category;
  late String rate;
  late String tag;
  final String name=Uuid().v1();
  final formkey=GlobalKey<FormState>();
  void savefunc(String file) async{
    var isvalid=formkey.currentState!.validate();
    if (isvalid) {
      formkey.currentState!.save();
      if(category=="blackcomedy" || category=="bluecomedy")
      {
        rate="A";
      }
      print(file); 
      File files=File(file);
      print(files);
     
      final ref=FirebaseStorage.instance.ref().child('jokes').child(rate).child(category).child(name);
      final put=await ref.putFile(files);
      final url=await put.ref.getDownloadURL();
      final data=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      final user=data['username'];
      final auid=await FirebaseAuth.instance.currentUser!.uid;
      
      final docidget=await FirebaseFirestore.instance.collection('publicjokes').doc();
      final comentid=await FirebaseFirestore.instance.collection('comments').doc().id;
      final setter=await docidget.set(
        {
           'title':title,
          'category':category,
          'rate':rate,
          'tag':tag,
          'path':url,
          'auid':auid,
          'author':user,
          'date':Timestamp.now(),
          'likes':0,
          'coid':comentid
        }
      );
      FirebaseFirestore.instance.collection('jokes').doc(FirebaseAuth.instance.currentUser!.uid).collection('joke').doc(docidget.id).set(
        {
           'title':title,
          'category':category,
          'rate':rate,
          'tag':tag,
          'path':url,
          'auid':auid,
          'author':user,
          'date':Timestamp.now(),
          'likes':0,
          'coid':comentid
        }
      );
      
     Navigator.pop(context);

    }
  }
  
  final List<Map<String, dynamic>> _genres = [
  {
    'value': 'Oneliner',
    'label': 'One liner',
  },
  {
    'value': 'blackcomedy',
    'label': 'Black comedy',
  },
  {
    'value': 'death',
    'label': 'Deadpan',
  },
  {
    'value': 'sarcasam',
    'label': 'Sarcasam',
  },
   {
    'value': 'dialouges',
    'label': 'Movie Dialouges',
  },
   {
    'value': 'story',
    'label': 'Story',
  },
   {
    'value': 'cringe',
    'label': 'Cringe',
  },
   {
    'value': 'bluecomedy',
    'label': 'Blue comedy',
  },
];
 final List<Map<String, dynamic>> _rate = [
  {
    'value': 'U',
    'label': 'for children',
  },
  {
    'value': 'UA',
    'label': 'for all',
  },
  {
    'value': 'A',
    'label': 'for adults',
  },
 
];
  @override
  Widget build(BuildContext context) {
    var args=ModalRoute.of(context)!.settings.arguments as Map<String ,String>;
    String file=args['file']!;
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
        
        
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 53, 53, 53),Color.fromARGB(255, 33, 33, 33), Colors.black])),
       
      child:Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: formkey,
        child: Column(

         
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 40,left: 10),
              child:  const Text('Joke Details',style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: 50,),
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
             decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text(' Enter the Title',style:TextStyle(color:  Color.fromARGB(255, 170, 170, 170))),
              
              labelStyle: TextStyle(
                color: Colors.white
              ),
            
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 159, 159, 159)),
                
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide( color:  Color.fromARGB(255, 159, 159, 159)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color:Color.fromARGB(255, 255, 0, 0)),
              ),
              
              
             ),
            validator: (value) {
                    if (value!.isEmpty ) {
                      return 'Can\'t be empty';
                    }
                    return null;
                  },
                  onSaved: (newValue) => title=newValue!,

            ),
           const SizedBox(height: 30,),
            SelectFormField(
               style:const TextStyle(color: Colors.white),
              
              decoration: const InputDecoration(
                
                border: OutlineInputBorder(),
                label: Text('Genre of the joke',style:TextStyle(color:  Color.fromARGB(255, 170, 170, 170))),
                labelStyle: TextStyle(
                  color: Colors.white
                ),
                 enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 159, 159, 159)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide( color:  Color.fromARGB(255, 159, 159, 159)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Color.fromARGB(255, 255, 0, 0)),
              ),
              ),
              items: _genres,
              
              onChanged: (val) => print(val),
              onSaved: (val) => category=val!,
              validator: (value){
                if (value!.isEmpty) {
                   return 'Can\'t be empty';
                }
                return null;
              },
            ),
             const SizedBox(height: 30,),
             SelectFormField(

                 style: const TextStyle(color: Colors.white),
                 
                 decoration: const InputDecoration(
                  
                   border: OutlineInputBorder(),
                  label: Text('Rate of the joke',style:TextStyle(color:  Color.fromARGB(255, 170, 170, 170))),
                  labelStyle: TextStyle(
                    color: Colors.white
                  ),
                 enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 159, 159, 159)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide( color:  Color.fromARGB(255, 159, 159, 159)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Color.fromARGB(255, 255, 0, 0)),
              ),
              ),
              
           
              items: _rate,
              
              onChanged: (val) => print(val),
              onSaved: (val) => rate=val!,
               validator: (value) {
                    if (value!.isEmpty ) {
                      return 'Can\'t be empty';
                    }
                    return null;
                  }

            ),
            const SizedBox(height: 30,),
            TextFormField(
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
             decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('# tags',style:TextStyle(color:  Color.fromARGB(255, 170, 170, 170))),
              
              labelStyle: TextStyle(
                color: Colors.white
              ),
              hintText: '# tags',
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 159, 159, 159)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 159, 159, 159)),
                
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide( color:  Color.fromARGB(255, 159, 159, 159)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color:Color.fromARGB(255, 255, 0, 0)),
              ),
              
              
             ),
            validator: (value) {
                    if (value!.isEmpty ) {
                      return 'Can\'t be empty';
                    }
                    return null;
                  },
                  onSaved: (newValue) => tag=newValue!,

            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              
              onPressed:()=>savefunc(file), child: Padding(padding: EdgeInsets.all(20),child: Text('Submit',),),
              style: ElevatedButton.styleFrom(
              shape:const StadiumBorder(),
              backgroundColor:Color.fromARGB(255, 82, 154, 84)
            ),
            )

          ],
        ),
      ),
    ),
      ),
      ),
       bottomNavigationBar: BottomNavigationBar(
        
         currentIndex: Provider.of<Navigate>(context,listen: true).currentindex,

        onTap: ((value) {
           var index=Provider.of<Navigate>(context,listen: true).currentindex;
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
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Color.fromARGB(255, 43, 43, 43),
        items: [
          BottomNavigationBarItem(icon: Icon( Icons.home_outlined,color: Colors.white,),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow_outlined,color: Colors.white,),label: 'Play'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up_outlined,color: Colors.white,),label: 'Trending')
        ],
       ),

    ),
    );
  }
}