class PopularModel {
  String? backdropPath;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  double? voteAverage;
  int? voteCount;

  PopularModel({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
  });

  factory PopularModel.fromMap(Map<String, dynamic> map){
    return PopularModel(
      backdropPath: map['backdrop_path']!=null?map['backdrop_path']:map['poster_path'],
      id:map['id'],
      originalLanguage: map['original_language'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'],
      releaseDate: map['release_date'],
      title: map['title'],
      voteAverage: (map['vote_average'] is int) ? (map['vote_average'] as int).toDouble():map['vote_average'],
      voteCount: map['vote_count'],
    );
  }

  Map<String, dynamic> toMap() {
  return {
    'backdrop_path': backdropPath,
    'id': id,
    'original_language': originalLanguage,
    'original_title': originalTitle,
    'overview': overview,
    'popularity': popularity,
    'poster_path': posterPath,
    'release_date': releaseDate,
    'title': title,
    'vote_average': voteAverage,
    'vote_count': voteCount,
  };
}
 
}
