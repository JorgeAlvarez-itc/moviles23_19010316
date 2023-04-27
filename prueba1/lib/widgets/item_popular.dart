import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/models/pupular_model.dart';
import 'package:prueba1/provider/flags_provider.dart';
import 'package:prueba1/database/database_helper.dart';
import 'package:prueba1/firebase/favorites_firebase.dart';

class ItemPopular extends StatefulWidget {
  ItemPopular({super.key, required this.popularModel});
  PopularModel popularModel;
  
  @override
  State<ItemPopular> createState() => _ItemPopularState();
}

class _ItemPopularState extends State<ItemPopular> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  FavoritesFirebase _firebase=FavoritesFirebase();
  
  @override
  Widget build(BuildContext context) {
    FlagsProvider flag= Provider.of<FlagsProvider>(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              fit: BoxFit.fill,
              placeholder: AssetImage('assets/loading1.gif'),
              image: NetworkImage('https://image.tmdb.org/t/p/w500/' +
                  widget.popularModel.posterPath.toString()),
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          right: 20,
          child: FutureBuilder(
              future: _firebase.searchPopular(widget.popularModel.id!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return IconButton(
                    icon: Icon(Icons.favorite),
                    color:snapshot.data!=true?Colors.white:Colors.red,
                    onPressed: () {
                      if(snapshot.data!=true){
                        databaseHelper.INSERT('tblPopularFav', widget.popularModel!.toMap()).then((value) => flag.setflagListPost());
                        _firebase.insFavorite(widget.popularModel.toMap()).then((value)=> flag.setflagListPost());
                      }else{
                        databaseHelper.DELETE('tblPopularFav', widget.popularModel.id!, 'id').then((value) => flag.setflagListPost());
                        _firebase.delFavorite(widget.popularModel.id!).then((value)=> flag.setflagListPost());
                      }
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ],
    );
  }
}
