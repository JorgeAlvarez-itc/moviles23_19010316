import 'package:flutter/widgets.dart';
import 'package:prueba1/screens/login_screen.dart';
import 'package:prueba1/screens/eventos_screen.dart';
import 'package:prueba1/screens/add_post_screen.dart';
import 'package:prueba1/screens/register_screen.dart';
import 'package:prueba1/screens/list_clash_cards.dart';
import 'package:prueba1/screens/dashboard_screen.dart';
import 'package:prueba1/screens/list_popular_videos.dart';
import 'package:prueba1/screens/modify_event_screen.dart';
import 'package:prueba1/screens/theme_select_screen.dart';
import 'package:prueba1/screens/movie_details_screen.dart';


Map<String,WidgetBuilder>getApplicationRoutes(){
  return <String,WidgetBuilder>{
    '/register':(BuildContext context) =>const RegisterScreen(),
    '/dash':(BuildContext context) =>DashboardScreen(),
    '/login':(BuildContext context) =>const LoginScreen(),
    '/theme':(BuildContext context) =>ThemeSelectionScreen(),
    '/eventos':(BuildContext context) => EventosScreen(),
    '/modify':(BuildContext context) => ModifyEvent(),
    '/add':(BuildContext context)=>AddPostScreen(),
    '/popular':(BuildContext context)=>ListPopularVideos(),
    '/clash':(BuildContext context)=>ListClashCard(),
  };
}