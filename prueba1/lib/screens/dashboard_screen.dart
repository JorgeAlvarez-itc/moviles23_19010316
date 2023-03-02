import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/provider/theme_provider.dart';
import 'package:prueba1/settings/styles_settings.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}


class _DashboardScreenState  extends State<DashboardScreen>{
  bool isDarkModeEnabled=false;
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
  Widget build(BuildContext context){
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
                backgroundImage: NetworkImage('https://images.deepai.org/machine-learning-models/d4b1dd3ee43648a997650dc7f9e6923f/panda.jpeg'),
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
                isDarkModeEnabled: isDarkModeEnabled!,
                onStateChanged: (isDarkModeEnabled){
                  isDarkModeEnabled
                  ? theme.setthemeData(1,context)
                  : theme.setthemeData(0,context);
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
