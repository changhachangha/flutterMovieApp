import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:movie_app/widget/moive_card.dart';
import 'package:movie_app/widget/movie_card_and_title.dart';
import 'package:movie_app/widget/movie_detail_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            color: Colors.black87,
            height: 3.5,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<Movie>> popularMovies = ApiService.getMovies('popular');
  final Future<List<Movie>> nowInMovies = ApiService.getMovies('now-playing');
  final Future<List<Movie>> commingSoonMovies =
      ApiService.getMovies('coming-soon');

  void viewDetailMovie(context, movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailCard(
          id: movie.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 120,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
              itemCount: 3, // 세 개의 섹션
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Popular Movies',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 200,
                          child: FutureBuilder<List<Movie>>(
                            future: popularMovies,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 20),
                                  itemBuilder: (context, index) {
                                    var popularMovies = snapshot.data![index];
                                    return GestureDetector(
                                      onTap: () => {
                                        viewDetailMovie(context, popularMovies)
                                      },
                                      child: MovieCard(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w500/${popularMovies.imageUrl}',
                                        height: 200,
                                        width: 300,
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  case 1:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Now in Cinemas',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 200,
                          child: FutureBuilder<List<Movie>>(
                            future: nowInMovies,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 20),
                                  itemBuilder: (context, index) {
                                    var nowInMovies = snapshot.data![index];
                                    return GestureDetector(
                                      onTap: () => {
                                        viewDetailMovie(context, nowInMovies)
                                      },
                                      child: MovieCardAndTitle(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w500/${nowInMovies.imageUrl}',
                                        movieTitle: nowInMovies.title,
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  case 2:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Coming soon',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 200,
                          child: FutureBuilder<List<Movie>>(
                            future: commingSoonMovies,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 20),
                                  itemBuilder: (context, index) {
                                    var commingSoonMovies =
                                        snapshot.data![index];
                                    return GestureDetector(
                                      onTap: () => {
                                        viewDetailMovie(
                                            context, commingSoonMovies)
                                      },
                                      child: MovieCardAndTitle(
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w500/${commingSoonMovies.imageUrl}',
                                        movieTitle: commingSoonMovies.title,
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
