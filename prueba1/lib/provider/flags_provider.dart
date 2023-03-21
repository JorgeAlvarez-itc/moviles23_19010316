import 'package:flutter/material.dart';

class FlagsProvider with ChangeNotifier
{
  bool _flagListPost=false;

  getflagListPost()=> this._flagListPost;
  setflagListPost(){
    this._flagListPost=!_flagListPost;
    notifyListeners();
  }
}