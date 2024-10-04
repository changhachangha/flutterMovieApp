import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_detail.dart';

class ApiService {
  static const String baseUrl = 'https://movies-api.nomadcoders.workers.dev';

  static Future<List<Movie>> getMovies(String endpoint) async {
    List<Movie> movieInstances = [];
    final url = Uri.parse('$baseUrl/$endpoint');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];

      for (var movie in movies) {
        movieInstances.add(Movie.fromJson(movie));
      }

      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetail> getMoviesDetail(int id) async {
    MovieDetail movieInstances;
    final url = Uri.parse('$baseUrl/movie?id=$id');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      movieInstances = MovieDetail.fromJson(jsonDecode(response.body));
      return movieInstances;
    }
    throw Error();
  }
}
