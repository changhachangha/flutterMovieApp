import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/services/api_service.dart';

class MovieDetailCard extends StatefulWidget {
  final int id;
  const MovieDetailCard({
    super.key,
    required this.id,
  });

  @override
  State<MovieDetailCard> createState() => _MovieDetailCardState();
}

class _MovieDetailCardState extends State<MovieDetailCard> {
  late final Future<MovieDetail> movieDetail;
  @override
  void initState() {
    super.initState();
    movieDetail = ApiService.getMoviesDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[400]),
        centerTitle: false,
        title: Text(
          'Back to List',
          style: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: movieDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500/${snapshot.data!.imageUrl}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.title,
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RatingBarIndicator(
                              rating: snapshot.data!.voteAverage / 2,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star_outlined,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 25.0,
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              ' ${(snapshot.data!.runtime / 60).round()}h ${snapshot.data!.runtime % 60}m | ${snapshot.data!.genres.map((item) => item['name'] as String).toList().join(', ')}',
                              style: TextStyle(
                                  color: Colors.grey[350],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Stroryline',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                          child: Text(
                            snapshot.data!.overview,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 30,
                        ),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.yellow[400],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Buy ticket',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
