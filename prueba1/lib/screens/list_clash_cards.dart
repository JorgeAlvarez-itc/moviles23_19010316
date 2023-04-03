import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:prueba1/networks/api_clash.dart';
import 'package:prueba1/screens/loading_screen.dart';
import 'package:prueba1/models/card_clash_model.dart';
import 'package:prueba1/widgets/clash_card_item.dart';

class ListClashCard extends StatefulWidget {
  const ListClashCard({super.key});

  @override
  State<ListClashCard> createState() => _ListClashCardState();
}

class _ListClashCardState extends State<ListClashCard> {
  // Crea una instancia del reproductor de audio
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayer audioPlayeraux = AudioPlayer();
  ApiClash? apiClash;

  // Reproduce la música al entrar a la vista
  Future<void> _playMusic() async {
    Future.delayed(Duration(seconds: 2)).then((_) {
      audioPlayeraux.play(
          'https://vgmsite.com/soundtracks/clash-royale-original-game-soundtrack/tjtkvfrnys/Menu%2003.mp3');
    });
  }

  // Detiene la música al salir de la vista
  Future<void> _stopMusic() async {
    await audioPlayer.stop();
    await audioPlayeraux.stop();
  }

  @override
  void initState() {
    super.initState();
    apiClash = ApiClash();
    _stopMusic();
    _playMusic();
  }

  @override
  void dispose() {
    _stopMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: apiClash!.getAllCards(),
          builder: (context, AsyncSnapshot<List<ClashCard>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingScreen(future: apiClash!.getAllCards());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Ocurrió un error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Cartas de Clash Royale'),
                ),
                body: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ItemClashCard(card: snapshot.data![index]);
                  },
                ),
              );
            } else {
              return SizedBox.shrink();
            }
            /*
          if(snapshot.hasData){
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
              ),
              itemCount: snapshot.data != null ? snapshot.data!.length : 0,
              itemBuilder: (context,index){
                 return ItemClashCard(card: snapshot.data![index]);
              }
            );
          }else if (snapshot.hasError) {
            return Center(
              child: Text('OCURRIO UN ERROR' + snapshot.error.toString()),
            );
          }else{
            return CircularProgressIndicator();
          }
          */
          }),
    );
  }
}
