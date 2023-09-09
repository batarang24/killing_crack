import 'package:flutter/material.dart';

class Navigate with ChangeNotifier
{
  int currentindex=0;
 

  void changeindex(int index)
  {
    currentindex=index;
    notifyListeners();
  }
}