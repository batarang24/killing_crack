import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Inner extends StatefulWidget {
 final title;
  int flags;
  List<String> lister;
  Function setflag;
  Inner(this.title,this.flags,this.setflag,this.lister);

  @override
  State<Inner> createState() => _InnerState();
}

class _InnerState extends State<Inner> {
 bool ischecked=true;

  @override
  Widget build(BuildContext context) {
  
    return InkWell(
      onTap: () async{
       

        if (widget.flags==3) {
          print('------------------------------------------------------------------------00--------');
           var docs= await FirebaseFirestore.instance.collection('jokes').doc(FirebaseAuth.instance.currentUser!.uid).collection('taste').doc().set({
          "array":FieldValue.arrayUnion(widget.lister)
          });
          Navigator.of(context).pushNamed('home');
          


        }
        var flager=widget.flags+1;
        
        widget.setflag(flager,widget.title);
      },
      splashColor: Colors.white,
      child:  Container(
      
      padding: EdgeInsets.all(20),
      //margin: EdgeInsets.all(10),
      child: Padding(
        padding:EdgeInsets.all(20),
        child: ListTile(
          title: Text(widget.title),
          trailing: Icon(Icons.grade),
        ),
      ),

      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    );
  }
}