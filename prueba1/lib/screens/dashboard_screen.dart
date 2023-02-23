import 'package:flutter/material.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:prueba1/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/settings/styles_settings.dart';

class DashboardScreen extends StatefulWidget {

  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme= Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Social ITC'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture:CircleAvatar(
                backgroundImage: NetworkImage('https://www.seekpng.com/png/full/966-9665493_my-profile-icon-blank-profile-image-circle.png'),
              ),
              accountName:Text('Practica 1 topicos moviles'),
              accountEmail: Text('practica1@itcelaya.edu.mx')
              ),
              ListTile(
                onTap: (){},
                title: Text('Practica 1'),
                subtitle: Text('Descripcion de la practica'),
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.chevron_right),
              ),
              DayNightSwitcher(
                isDarkModeEnabled: isDarkModeEnabled,
                onStateChanged: (isDarkModeEnabled){
                  isDarkModeEnabled
                  ? theme.setthemeData(StylesSettings.darckTheme(context))
                  : theme.setthemeData(StylesSettings.lightTheme(context));
                  this.isDarkModeEnabled=isDarkModeEnabled;
                  setState(() {});
                },
              ),
          ],
        ),
      ),
    );
  }
}