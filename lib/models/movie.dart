class Movie {
  final String title;
  final String imageUrl;
  final int id;

  Movie.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        imageUrl = json['poster_path'],
        id = json['id'];
}
