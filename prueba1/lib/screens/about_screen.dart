import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:prueba1/responsive.dart';
import 'package:prueba1/widgets/card_info.dart';
import 'package:concentric_transition/concentric_transition.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);

  final data = [
    CardInfoData(
      title: "Nuestro Instituto",
      subtitle:
          "TecNM en Celaya",
      image: const AssetImage("assets/fondo_itce.jpg"),
      backgroundColor: const Color.fromRGBO(26, 38, 24, 0.99),
      titleColor: Color.fromARGB(255, 255, 255, 255),
      subtitleColor: Colors.white,
      //background: LottieBuilder.asset("assets/animation/bg-1.json"),
    ),
    CardInfoData(
      title: "Nuestra carrera",
      subtitle: "Ingeniería en Sistemas Computacionales",
      image: const AssetImage("assets/fondo_carrera.jpg"),
      backgroundColor:const Color.fromRGBO(5, 5, 5, 0.99),
      titleColor: Color.fromARGB(255, 255, 255, 255),
      subtitleColor: Color.fromARGB(255, 255, 255, 255),
      background: LottieBuilder.asset("assets/animation/bg-2.json"),
    ),
    CardInfoData(
      title: "Nuestras instalaciones",
      subtitle: '''Antonio García Cubas
                   Pte #1200 esq. Ignacio Borunda
                   Celaya, Gto. México''',
      image: const AssetImage("assets/fondo_inst.jpg"),
      backgroundColor: const Color.fromRGBO(167, 128, 99, 0.99),
      titleColor: Color.fromRGBO(1, 55, 65, 0.9),
      subtitleColor: Colors.white,
      //background: LottieBuilder.asset("assets/animation/bg-3.json"),
    ),
  ];

@override
Widget build(BuildContext context) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      return Responsive(
        mobile: Scaffold(
          body: ConcentricPageView(
            colors: data.map((e) => e.backgroundColor).toList(),
            itemCount: data.length,
            itemBuilder: (int index) {
              return CardInfo(data: data[index]);
            },
            onFinish: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ),
        tablet: Scaffold(
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
             Expanded(
                flex: 1,
                child: ConcentricPageView(
                  colors: data.map((e) => e.backgroundColor).toList(),
                  itemCount: data.length,
                  itemBuilder: (int index) {
                    return CardInfo(data: data[index]);
                  },
                  onFinish: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ),
            ],
          ),
        ),
        desktop: Scaffold(
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              Expanded(
                flex: 1,
                child: ConcentricPageView(
                  colors: data.map((e) => e.backgroundColor).toList(),
                  itemCount: data.length,
                  itemBuilder: (int index) {
                    return CardInfo(data: data[index]);
                  },
                  onFinish: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
}