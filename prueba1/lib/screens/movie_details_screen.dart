import 'package:flutter/material.dart';
import 'package:prueba1/models/actor_model.dart';
import 'package:prueba1/models/pupular_model.dart';
import 'package:prueba1/networks/api_popular.dart';
import 'package:prueba1/widgets/actor_card_info.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailScreen extends StatelessWidget {
  ApiPopular apiPopular=ApiPopular();

  final PopularModel modelito;
  MovieDetailScreen({Key? key, required this.modelito}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: modelito.id!,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 250,
                child: Stack(
                  children: [
                    FutureBuilder(
                        future: apiPopular.getIdVideo(modelito!.id!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return YoutubePlayer(
                              controller: YoutubePlayerController(
                                initialVideoId: snapshot.data.toString(),
                                flags: YoutubePlayerFlags(
                                    autoPlay: true,
                                    mute: false,
                                    controlsVisibleAtStart: true),
                              ),
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.red,
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://image.tmdb.org/t/p/w500/' +
                          modelito!.backdropPath.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modelito!.title.toString(),
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        SizedBox(width: 10),
                        Text(
                          modelito!.voteAverage.toString(),
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Sinopsis',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      modelito!.overview.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Row(
                      
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Actores',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    FutureBuilder<List<ActorModel>?>(
                      future: apiPopular.getAllAuthors(modelito!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                ActorModel actor = snapshot.data![index];
                                return ActorCard(
                                  name: actor.name.toString(),
                                  photoUrl:
                                      'https://image.tmdb.org/t/p/original${actor.profilePath}',
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
