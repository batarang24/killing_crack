
import 'package:flutter/material.dart';
class Tiles extends StatelessWidget {
  final String title;
  final icon;
 VoidCallback callback;
  Tiles(this.title,this.icon,this.callback);

  @override
  Widget build(BuildContext context) {
    return  ListTile(
               onTap:callback,
                leading:Container(
                  height: 100,
                  width: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                          Color.fromARGB(255, 36, 0, 215),
                          Color.fromARGB(255, 15, 93, 251),
                          Color.fromARGB(255, 4, 209, 240)
                      ]
                    )
                  ),
                  child: Icon(icon,size: 30,color: Color.fromARGB(255, 200, 200, 200),),
                ) ,
                title: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color:  Color.fromARGB(255, 224, 223, 223)),),
                subtitle: Text('by Naren',style: TextStyle(color: Color.fromARGB(255, 162, 162, 162)),),
              );
  }
}