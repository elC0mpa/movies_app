class Movie {
  late int voteCount;
  late int id;
  late bool video;
  late double voteAverage;
  late String title;
  late double popularity;
  late String posterPath;
  late String originalLanguage;
  late String originalTitle;
  late List<int> genreIds;
  late String backdropPath;
  late bool adult;
  late String overview;
  late String releaseDate;

  Movie(
      {required this.voteCount,
      required this.id,
      required this.video,
      required this.voteAverage,
      required this.title,
      required this.popularity,
      required this.posterPath,
      required this.originalLanguage,
      required this.originalTitle,
      required this.genreIds,
      required this.backdropPath,
      required this.adult,
      required this.overview,
      required this.releaseDate});

  Movie.fromJsonMap(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    title = json['title'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  String getPosterImage() {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  String getBackgroundImage() {
    return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }
}

class Movies {
  List<Movie> movies = [];

  Movies();

  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return;

    for (var item in jsonList) {
      movies.add(Movie.fromJsonMap(item));
    }
  }
}
