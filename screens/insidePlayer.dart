import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../Providers/Navigate.dart';

class Insideplayer extends StatefulWidget {
 
  List<Map<String,dynamic>> audiourl;
  List<Map<String,dynamic>> details;
  Insideplayer(this.audiourl,this.details);
  

  @override
  State<Insideplayer> createState() => _InsideplayerState();
}

class _InsideplayerState extends State<Insideplayer> {
  bool init=true;
  AudioPlayer player=new AudioPlayer();
   late String img;
   late String title='hwllo';
   late int index;

   
 
  List<AudioSource> kingurl=[];
  List<AudioSource> get geturl {
      widget.audiourl.forEach((element) {
        kingurl.add(
          element['url']
        );
      });
    return kingurl;
  }
   
   void titles ()  {
    if (player.currentIndex!=null) {
      //return widget.details[player.currentIndex!]['title'];
    }
    else
    {
      //return '';
    }
    
  }
   
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (player.currentIndex!=null) {
       setState(() {
          index=player.currentIndex!;
       });
    }
    else
    {
      setState(() {
        index=0;
      });
    }
  }
  void prev()async{
    setState(() {
      index=( player.previousIndex)!;
    });
    await player.seekToPrevious();
  }
  void next()async{
     setState(() {
        index= ( player.nextIndex)!;
      });
      await player.seekToNext();
  }

  @override
  void didChangeDependencies() async{
    
   super.didChangeDependencies();
   
   Timer timer = new Timer(new Duration(seconds: 10), () {
    setState(() {
       index=player.currentIndex!;
    });
    print('IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII${index}');
     
  });

   if (init) {
      print(widget.details);
    if(widget.audiourl.isNotEmpty)
    {
       final playlist = await ConcatenatingAudioSource(
      
      useLazyPreparation: true,
      
      children:geturl
      
      );
      await player.setAudioSource(playlist, initialIndex: 0, initialPosition: Duration.zero);
      //print(player.);
      //player.
      await player.setLoopMode(LoopMode.all);
      if (player.playing) {
        await player.stop();
      }
      else
      {
          await player.play();
          //print(await  player.currentIndex);
          
      }
  
    }
    init=false;
   }

      
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.stop();
    player.dispose();
    
  }
    bool plays=true;
  @override
  Widget build(BuildContext context) {
  
    void hellyeah()
    {
      //print(player.audioSource.hashCode);
      setState(() {
        plays=!plays;
      });
      player.playing?player.pause():player.play();
    }
    void modalshower()
    {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          color: Color.fromARGB(255, 37, 37, 37),
          height: 400,
          child: Column(
            children: [
             Container(
              margin: EdgeInsets.only(top: 20,left: 5),
              child:  Row(
                
                children: [
                 Flexible(
                  
                  child:  SizedBox(
                    height: 30,
                    child: TextField(
                  
                  style: TextStyle(fontSize: 15,color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText:'write something',
                    hintStyle: TextStyle(color: Color.fromARGB(255, 161, 161, 161)),
                    contentPadding: EdgeInsets.only(top: 13,left: 5),
                    border: OutlineInputBorder(
                      
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 155, 155, 155)
                      ),
                      
                     // borderRadius: BorderRadius.circular(40)
                    )
                  )
                ),
                  ),
                 ),
                IconButton(onPressed: (){}, icon:Icon(Icons.send,color: Colors.white,))
                ],
              ),
             ),
              
            ],
            
          ),
        );
      });
    }
    return WillPopScope(
      onWillPop: ()async=>false,
      child:  Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
           gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
             colors: [Color.fromARGB(255, 77, 77, 77),Color.fromARGB(255, 43, 43, 43), Colors.black]))
        ,
   
         
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
               // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/8),
                width:  250,
                height: 250,
                //color: Colors.white,
                decoration: BoxDecoration(
                  color: Colors.white,
                 image: DecorationImage(
                  image: AssetImage('assets/cheems.png'),
                  fit:BoxFit.cover
                 )
                  
                ),
              ),
              StreamBuilder(
                stream: player.currentIndexStream,
                builder: ((context, snapshot) {
                  int currentIndex=snapshot.data??0;
                  return Container(
                
                margin: EdgeInsets.only(top: 70,left: 20,right: 20),
                //height: 100,
                width: MediaQuery.of(context).size.width,
                //color: Colors.green,
                child: Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.details[currentIndex]['title'],style: TextStyle(
                      fontSize: 25,
                      color: Colors.white
                    ),),
                    SizedBox(height: 10,),
                    Text(widget.details[currentIndex]['author'],style: TextStyle(
                      color: Color.fromARGB(255, 210, 210, 210)
                    ),)
                  ],  
                ),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outlined),color: Colors.white,),
                 IconButton(onPressed: modalshower, icon: Icon(Icons.comment),color: Colors.white,)
                  ],
                ),
              
              
              );
                }),
              ),
              Container(
              
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                //color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(onPressed:prev, icon:Icon(Icons.skip_previous_sharp),color: Colors.white,iconSize:50,),
                    IconButton(onPressed:hellyeah, icon:  Icon(plays?Icons.pause_circle:Icons.play_circle),color: Colors.white,iconSize: 70,),
                    IconButton(onPressed: next, icon: Icon(Icons.skip_next_sharp),color: Colors.white,iconSize: 50,)
                  ],
                ),
              ),
             
             
            ],
          ),
        
      ),
      
       bottomNavigationBar: BottomNavigationBar(
         currentIndex: Provider.of<Navigate>(context,listen: true).currentindex,
        onTap: ((value) {
          switch (value) {
            case 0: Navigator.of(context).pushNamed('Profile');
                    break;

            case 1:{
              Navigator.pop(context);
              Navigator.of(context).pushNamed('Player');
              break;
            }
            
            
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
    );;
  }
}