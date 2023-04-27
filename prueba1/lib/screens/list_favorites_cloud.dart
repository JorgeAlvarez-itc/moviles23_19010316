import 'package:flutter/material.dart';
import 'package:prueba1/models/pupular_model.dart';
import 'package:prueba1/widgets/item_popular.dart';
import 'package:prueba1/firebase/favorites_firebase.dart';


class ListFavoritesCloud extends StatefulWidget {
  const ListFavoritesCloud({super.key});

  @override
  State<ListFavoritesCloud> createState() => _ListFavoritesCloudState();
}

class _ListFavoritesCloudState extends State<ListFavoritesCloud> {
  
  FavoritesFirebase _firebase=FavoritesFirebase();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder(
        stream: _firebase.getAllFavorites(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return GridView.builder(
              padding: EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
              ),
              itemCount:snapshot.data!.docs.length,
              itemBuilder: (context,index){
                PopularModel popularModel =PopularModel.fromQuerySnapshot(snapshot.data!.docs[index]);
                return ItemPopular(popularModel: popularModel);
              }
            );
          }else if(snapshot.hasError){
            return const Center(
              child: Text('Error al realizar la peticion xd'),
            );
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ) ,
    );
  }
}