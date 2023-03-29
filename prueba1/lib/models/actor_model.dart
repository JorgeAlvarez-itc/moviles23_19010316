class ActorModel {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;

  ActorModel(
      {this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.originalName,
      this.popularity,
      this.profilePath,
      this.castId,
      this.character,
      this.creditId,
      this.order});

  factory ActorModel.fromMap(Map<String, dynamic> map) {
    return ActorModel(
    adult : map['adult'],
    gender : map['gender'],
    id : map['id'],
    knownForDepartment : map['known_for_department'],
    name : map['name'],
    originalName : map['original_name'],
    popularity : map['popularity'],
    profilePath : map['profile_path'],
    castId : map['cast_id'],
    character : map['character'],
    creditId : map['credit_id'],
    order : map['order'],
    );
    
  }
}
