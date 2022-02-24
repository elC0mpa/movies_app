import 'package:flutter/material.dart';

import '../components/cards_swipper.dart';
import '../components/populars.dart';
import '../models/movies.dart';
import '../providers/movies_provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _moviesProvider = MoviesProvider();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _moviesProvider.getPlayingNow();
    _moviesProvider.getPopular();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
          centerTitle: false,
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FutureBuilder(
              future: _moviesProvider.getPlayingNow(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
                if (snapshot.hasData) {
                  return CardsSwipper(movies: snapshot.data as List<Movie>);
                } else {
                  return const SizedBox(
                      height: 400,
                      child: Center(child: CircularProgressIndicator()));
                }
              },
            ),
            StreamBuilder(
              stream: _moviesProvider.popularMoviesStream,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
                if (snapshot.hasData) {
                  return Populars(
                    popularMovies: snapshot.data as List<Movie>,
                    nextPagePopulars: _moviesProvider.getPopular,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ));
  }
}
