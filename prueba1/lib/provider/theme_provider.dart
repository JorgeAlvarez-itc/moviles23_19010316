import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../settings/styles_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider with ChangeNotifier{

  ThemeData? _themeData;

  ThemeProvider(int id_tema,BuildContext context){
    setthemeData(id_tema, context);
  }

 
  getthemeData()=> this._themeData;
  setthemeData(int? index, BuildContext context) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (index){
      case 1:
        _themeData=StylesSettings.darckTheme(context);
        sharedPreferences.setInt('id_tema', 1);
        await sharedPreferences.setBool('is_dark', true);
        break; 
      case 2:
        _themeData=StylesSettings.personalTheme(context);
        sharedPreferences.setInt('id_tema', 2);
        break;
      default:
        _themeData=StylesSettings.lightTheme(context);
        sharedPreferences.setInt('id_tema', 0);
        await sharedPreferences.setBool('is_dark', false);
        break;
    }
    notifyListeners();
  }
}