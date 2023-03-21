import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/models/post_model.dart';
import 'package:prueba1/provider/flags_provider.dart';
import 'package:prueba1/database/database_helper.dart';
import 'package:prueba1/widgets/item_post_widget.dart';

class ListPost extends StatefulWidget {
  const ListPost({super.key});

  @override
  State<ListPost> createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {

  DatabaseHelper? database;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database=DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag= Provider.of<FlagsProvider>(context);
    return FutureBuilder(
      future: flag.getflagListPost()==true? database!.GETALLPOST():database!.GETALLPOST(),
      builder: (context,AsyncSnapshot<List<PostModel>> snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var objPostModel=snapshot.data![index];
              return ItemPostWidget(objPostModel: objPostModel);
            },
          );
        }else if(snapshot.hasError){
          return const Center(child: Text('Ocurrió un error'),);
        }else{
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}