import 'package:flutter/material.dart';

class StylesSettings{
  
  static ThemeData lightTheme(BuildContext? context){
    final theme=ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context!).colorScheme.copyWith(
        primary: Color.fromARGB(255, 97, 213, 82)
      )
    );
  } 

  static ThemeData darckTheme(BuildContext? context){
    final theme=ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context!).colorScheme.copyWith(
        primary: Color.fromARGB(255, 0, 60, 21)
      )
    );
  }
}