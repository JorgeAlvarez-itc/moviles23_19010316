import '../responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/provider/theme_provider.dart';


class ThemeSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Theme'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/fondo.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Responsive(
            mobile: buildMobileLayout(theme, context),
            desktop: buildDesktopLayout(theme, context),
          ),
        ],
      ),
    );
  }

  Widget buildMobileLayout(ThemeProvider theme, BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Seleccione un tema',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                theme.setthemeData(0, context);
              },
              child: Text(
                'Light theme',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                theme.setthemeData(1, context);
              },
              child: Text('Dark theme'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                theme.setthemeData(2, context);
              },
              child: Text(
                'Custom theme',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 185, 236, 255),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Guardar',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 0, 255, 47),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      theme.setthemeData(0, context);
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Cancelar'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 77, 0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDesktopLayout(ThemeProvider theme, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/fondo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          width: 600,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Seleccione un tema',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      theme.setthemeData(0, context);
                    },
                    child: Text(
                      'Light theme',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      theme.setthemeData(1, context);
                    },
                    child: Text('Dark theme'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      theme.setthemeData(2, context);
                    },
                    child: Text(
                      'Custom theme',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 185, 236, 255),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Guardar',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 0, 255, 47),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      theme.setthemeData(0, context);
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text('Cancelar'),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 77, 0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
