import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:prueba1/models/user_model.dart';
import 'package:prueba1/screens/list_post.dart';
import 'package:prueba1/firebase/google_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:prueba1/firebase/facebook_auth.dart';
import 'package:prueba1/provider/theme_provider.dart';
import 'package:prueba1/settings/styles_settings.dart';
import 'package:prueba1/screens/list_favorites_cloud.dart';
import 'package:prueba1/widgets/awesomeDialog_widget.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkModeEnabled = false;
  AudioPlayer audioPlayer = AudioPlayer();
  GoogleAuth googleAuth= GoogleAuth();
  FaceAuth faceAuth= FaceAuth();
  Awesome awesome= Awesome(); 
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _loadDarkModeEnabled();
  }

  Future<void> _loadDarkModeEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkModeEnabled = prefs.getBool('is_dark') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(ModalRoute.of(context)!.settings.arguments!=null){
      user = ModalRoute.of(context)!.settings.arguments as UserModel;
    }
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Social ITC'),
      ),
      body: ListFavoritesCloud(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add post'),
        icon: const Icon(Icons.add_comment),
        onPressed: () {
          Navigator.pushNamed(context, '/add').then((value) {
            setState(() {});
          });
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(user!.photoUrl.toString()),
                ),
                accountName: Text(user!.name.toString()),
                accountEmail: Text(user!.email.toString())),
            ListTile(
              onTap: () {},
              title: Text('Practica 1'),
              subtitle: Text('Descripcion de la practica'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () {
                 Navigator.pushNamed(context, '/eventos');
              },
              leading: Icon(Icons.calendar_today),
              title: Text('Eventos'),
            ),
            ListTile(
              onTap: (){Navigator.pushNamed(context, '/popular');},
              title: Text('API videos'),
              leading: Icon(Icons.movie),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: (){Navigator.pushNamed(context, '/favs');},
              title: Text('Popular favs cloud'),
              leading: Icon(Icons.cloud),
              trailing: Icon(Icons.chevron_right),
            ),
            ListTile(
              onTap: () async{
                await audioPlayer.play('https://vgmsite.com/soundtracks/clash-royale-original-game-soundtrack/afzbmphjha/Scroll%20Loading%2001.mp3');
                Future.delayed(Duration(seconds: 1)).then((_) => {
                  Navigator.pushNamed(context, '/clash')
                });
              },
              title: Text('Clash royale'),
              leading: Icon(Icons.gamepad),
              trailing: Icon(Icons.chevron_right),
            ),
            DayNightSwitcher(
              isDarkModeEnabled: isDarkModeEnabled!,
              onStateChanged: (isDarkModeEnabled) {
                isDarkModeEnabled
                    ? theme.setthemeData(1, context)
                    : theme.setthemeData(0, context);
                this.isDarkModeEnabled = isDarkModeEnabled;
                setState(() {});
              },
            ),
            ListTile(
              onTap: (){
                try{
                  awesome.buildDialog(context,
                   DialogType.infoReverse, 
                   'Confirmar',
                   '¿Realmente desea cerrar la sesión?',
                   '/login',
                   AnimType.bottomSlide, 
                   true).show().then((value) {
                    print(value);
                   });
                  
                }catch(e){
                  print(e);
                }
              },
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
