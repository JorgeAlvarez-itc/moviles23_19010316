import 'package:prueba1/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prueba1/screens/about_screen.dart';
import 'package:prueba1/screens/login_screen.dart';
import 'package:prueba1/provider/flags_provider.dart';
import 'package:prueba1/provider/theme_provider.dart';
import 'package:prueba1/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
  final id_tema=sharedPreferences.getInt('id_tema')??0;
  runApp(MyApp( id_tema :id_tema));
}

class MyApp extends StatelessWidget {
  final int id_tema;
  const MyApp({super.key, required this.id_tema});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:(_)=>ThemeProvider(id_tema,context)
        ),
        ChangeNotifierProvider(create: (_)=>FlagsProvider()),
      ],
      child: PMSNApp(),
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme= Provider.of<ThemeProvider>(context);
    return  MaterialApp(
      theme: theme.getthemeData(),
      routes: getApplicationRoutes(),
      home: LoginScreen(),
    );
  }
}
