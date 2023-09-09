import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paduka/screens/Inner.dart';
import 'package:provider/provider.dart';

import '../Providers/Navigate.dart';

class Flag extends StatefulWidget {
  const Flag({super.key});

  @override
  State<Flag> createState() => _FlagState();
}

class _FlagState extends State<Flag> {
  List<String> category=['Kids','Black comedy','Blue comedy','Sarcasam'];
  List<String> categoryfinal=[];
   int flags=0;
  void setflag(int flag,String title)
  {
    setState(() {
      flags=flag;
      categoryfinal.add(title);
      category.remove(title);
    });

  }
  @override
  Widget build(BuildContext context) {
   
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
      body: 
         GridView.builder(
        itemCount: category.length,
        gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20
        ),
        itemBuilder: (context, index) {
          return Inner(category[index],flags,setflag,categoryfinal);
        },
        ),
       
       
      
     
    ),
    );
  }
}