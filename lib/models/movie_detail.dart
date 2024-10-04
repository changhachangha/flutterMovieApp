class MovieDetail {
  final String title, imageUrl, overview;
  final double voteAverage;
  final int runtime;
  final List genres;
  MovieDetail.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        imageUrl = json['poster_path'],
        overview = json['overview'],
        voteAverage = json['vote_average'],
        runtime = json['runtime'],
        genres = json['genres'];
}
