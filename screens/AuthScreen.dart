import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthScreen extends StatefulWidget {
 
  

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late String  email;
  late String name;
  late String password;
  final auth=FirebaseAuth.instance;
  final store=FirebaseFirestore.instance;

  final formkey=GlobalKey<FormState>();

  bool islogin=true;
  void savefunc(BuildContext ctx) async{
    UserCredential authresult;
    var isvalid=formkey.currentState!.validate();
    if (isvalid) {
      formkey.currentState!.save();
     
     try {
        if (islogin) {
         authresult= await auth.signInWithEmailAndPassword(email: email, password: password);
      }
      else
      {
       
         authresult= await auth.createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance.collection('users').doc(authresult.user!.uid).set({
          'email':email,
          'username':name,
          'password':password
        });
         Navigator.of(ctx).pushNamed(
          'Flag'
        );
        
      }
     }on PlatformException catch (err) {
      
       var mssg="An error has been occurred";
      print('fsfssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
       if (err.message!=null) {
         mssg=err.message!;
       }
       print('==========================================================================');
       final snack=SnackBar(
          content: Text(mssg),
          backgroundColor: Colors.red
        );
      ScaffoldMessenger.of(context).showSnackBar(snack);
     }catch(err)
     {
      
      print('errrrrrrorrrrrr');
       final snack=SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.red
        );
      ScaffoldMessenger.of(context).showSnackBar(snack);
     }
     
    }
  }
  @override
  Widget build(BuildContext context) {
   
      return Center(
        child: Card(
         child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
           child: Form(
            key: formkey,
            child: Column(
              children: [
          
                TextFormField(
                  key: ValueKey('email'),
                  decoration: InputDecoration(
                    labelText: 'Email address'
                  ),
                   validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    onSaved: (value){
                      email=value!;
                    },
                ),
                if(!islogin) TextFormField(
                  key: ValueKey('username'),
                  decoration: InputDecoration(
                    labelText: 'Username'
                  ),
                  validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please enter at least 4 characters';
                        }
                        return null;
                      },
                        onSaved: (value){
                      name=value!;
                    }
                ),
                TextFormField(
                   key:ValueKey('password'),
                  decoration: InputDecoration(
                    labelText: 'Password'
                  ),
                   validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value){
                      password=value!;
                    }
                ),
                SizedBox(height: 10,),
               TextButton(onPressed: (){
                  setState(() {
                    islogin= !islogin;
                  });
               }, child:Text( islogin?'New user?':'Already an user?')),

                ElevatedButton(
                  child: Text(islogin?'Login':'Signup'),
                  onPressed:()=>savefunc(context),
                )
                
              ],
              
            ),
           ),
          ),
         ),
        ),
          
      );
      
  
  }
}