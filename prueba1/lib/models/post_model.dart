class PostModel {
  int? idPost;
  String? descPost;
  String? datePost;

  PostModel({this.idPost,this.descPost,this.datePost});
  factory PostModel.fromMap(Map<String, dynamic> map){
    return(PostModel(
      idPost: map['idPost'],
      descPost: map['descPost'],
      datePost: map['datePost']
    ));
  }

}