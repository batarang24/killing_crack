import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../Providers/Navigate.dart';

class Myjokes extends StatefulWidget {
  const Myjokes({super.key});

  @override
  State<Myjokes> createState() => _MyjokesState();
}

class _MyjokesState extends State<Myjokes> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
           gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 65, 56, 194),Color.fromARGB(255, 26, 26, 26),Color.fromARGB(255, 17, 17, 17),Color.fromARGB(255, 14, 14, 14), Colors.black]),
     
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(top:100),
              height: 150,
           
              child: Column(
                mainAxisAlignment:MainAxisAlignment.spaceAround,

                children: [
                  Text('My Jokes',style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                
                  ),),
                  ElevatedButton(onPressed: (){}, child:Padding(padding: EdgeInsets.all(17), child:  Icon(Icons.play_arrow,size: 30,),),style: IconButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: Colors.green,
                    
                  ),)
                ],
              ),
            ),
           Expanded(
            child:  ListView.builder(
              itemCount: 49,
              itemBuilder: ((context, index) {
                return 
                
                   Container(
                    margin: EdgeInsets.only(left: 10),
                    child:  ListTile(
                   leading:  Column(mainAxisAlignment: MainAxisAlignment.center,children: [ Text('${index+1}.',style: TextStyle(color: Color.fromARGB(255, 138, 138, 138)),)],),
                    title:Text('Hello world',style: TextStyle(color: Colors.white),),
                      

                    
                    subtitle:  Text('Naren',style: TextStyle(color: Color.fromARGB(255, 138, 138, 138)),),
                     
                    trailing: Wrap(
                      spacing: 10,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite,color: Colors.green,size: 20,),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    
               
                  ),
                   );
              
              
              }),
            ),
           )
          ],
        ),
      ),
       bottomNavigationBar: BottomNavigationBar(
         currentIndex: Provider.of<Navigate>(context,listen: true).currentindex,
        onTap: ((value) {
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
          BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.white,),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.play_arrow_sharp,color: Colors.white,),label: 'Play'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up,color: Colors.white,),label: 'Trending')
        ],
       ),
    ),
    );
  }
}