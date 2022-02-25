import 'package:flutter/material.dart';

import '../models/movies.dart';
import '../providers/movies_provider.dart';

class MovieSearch extends SearchDelegate {
  final moviesProvider = MoviesProvider();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Container()
        : FutureBuilder(
            builder:
                (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.map((movie) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 2.5),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                              placeholder:
                                  const AssetImage('assets/imgs/no-image.png'),
                              image: NetworkImage(movie.getPosterImage())),
                        ),
                        title: Text(movie.title),
                        onTap: () {
                          close(context, null);
                          Navigator.pushNamed(context, 'movie-details',
                              arguments: movie);
                        },
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            future: moviesProvider.searchMovie(query),
          );
  }
}
