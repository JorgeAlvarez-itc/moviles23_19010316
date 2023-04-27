import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesFirebase{
  FirebaseFirestore? _fire;
  CollectionReference? _favoriteCollection;
  FavoritesFirebase(){
    _fire=FirebaseFirestore.instance;
    _favoriteCollection=_fire!.collection('favoritos');
  }

  Future<void> insFavorite(Map<String,dynamic> map) async{
    return _favoriteCollection!.doc().set(map);
  }

  Future<void> upFavorite(Map<String,dynamic> map, String id) async{
    return _favoriteCollection!.doc(id).update(map);
  }

  Future<void> delFavorite(int id) async {
    try {
      await _fire!.runTransaction((transaction) async {
        final querySnapshot =
            await _favoriteCollection!.where('id', isEqualTo: id).get();
        if (querySnapshot.docs.isNotEmpty) {
          final documentReference = querySnapshot.docs[0].reference;
          await transaction.delete(documentReference);
        }
      });
    } catch (e) {
      print('Error deleting document: $e');
    }
  }
  Stream<QuerySnapshot> getAllFavorites(){
    return _favoriteCollection!.snapshots();
  }

  Future<bool> searchPopular(int id) async{
   bool aux=false;
   try {
      await _fire!.runTransaction((transaction) async {
        final querySnapshot =
            await _favoriteCollection!.where('id', isEqualTo: id).get();
        if (querySnapshot.docs.isNotEmpty) {
          aux=true;
        }else{
          aux=false;
        }
      });
    } catch (e) {
      aux=false;
    }
    return aux;
  }
}