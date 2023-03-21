import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/models/post_model.dart';
import 'package:prueba1/provider/flags_provider.dart';
import 'package:prueba1/database/database_helper.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key,this.objPostModel});

  PostModel? objPostModel;

  DatabaseHelper database= DatabaseHelper();

  @override
  Widget build(BuildContext context) {

    final avatar = CircleAvatar(
      backgroundImage: AssetImage('assets/logo.png'),
    );
    final txtUser  = Text('Usuername');
    final datePost = Text('06-03-2023');
    final imgPost = Image(image:AssetImage('assets/logo.png'),height: 100,);
    final txtDesc = Text(objPostModel!.descPost.toString());
    final iconRate = Icon(Icons.rate_review);

    FlagsProvider flag= Provider.of<FlagsProvider>(context);
    
    return Container(
      margin: EdgeInsets.all(17),
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius:BorderRadius.circular(10)
      ),
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                avatar,
                txtUser,
                datePost
              ],
            ),
            Row(
              children: [
                imgPost,
                txtDesc
              ],
            ),
            Row(
              children: [
                iconRate,
                Expanded(child:Container()),
                IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/add', arguments:objPostModel);
                  }, icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title:  Text('Confirmar borrado'),
                        content: Text('Deseas borrar el post?'),
                        actions: [
                          TextButton(
                            onPressed: (){
                              database.DELETE('tblPost', objPostModel!.idPost!,'idPost').then((value) => flag.setflagListPost());
                              Navigator.pop(context);
                            }, 
                            child: const Text('SI')
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Text('No')
                          )
                        ],
                      )
                    );
                  }, 
                  icon: Icon(Icons.delete),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}