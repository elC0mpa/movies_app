import 'dart:async';
import 'dart:convert';

import 'package:movies_app/models/actors.dart';
import 'package:movies_app/models/movies.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  final String _apiKey = '371e418316bc84db563e2c57ff2926d0';
  final String _url = 'api.themoviedb.org';
  bool _loadingPopularMovies = false;

  int _popularsPaginationPage = 0;
  final List<Movie> _popularMovies = [];

  final _popularMoviesStreamController =
      StreamController<List<Movie>>.broadcast();
  Function(List<Movie>) get popularMoviesSink =>
      _popularMoviesStreamController.sink.add;
  Stream<List<Movie>> get popularMoviesStream =>
      _popularMoviesStreamController.stream;

  void disposeSttreams() {
    _popularMoviesStreamController.close();
  }

  Future<List<Movie>> getPlayingNow() async {
    final url = Uri.https(_url, '3/movie/now_playing', {'api_key': _apiKey});

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final results = decodedData['results'];
    return Movies.fromJsonList(results).movies;
  }

  Future<List<Movie>> getPopular() async {
    if (_loadingPopularMovies) return [];
    _loadingPopularMovies = true;
    _popularsPaginationPage++;
    final url = Uri.https(_url, '3/movie/popular',
        {'api_key': _apiKey, 'page': _popularsPaginationPage.toString()});

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final results = decodedData['results'];
    final actualPageMovies = Movies.fromJsonList(results).movies;
    _popularMovies.addAll(actualPageMovies.toList());
    popularMoviesSink(_popularMovies);
    _loadingPopularMovies = false;
    return actualPageMovies;
  }

  Future<List<Actor>> getCastForMovie(String movieId) async {
    final url =
        Uri.https(_url, '3/movie/$movieId/credits', {'api_key': _apiKey});

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    return Cast.fromJsonList(decodedData['cast']).actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url =
        Uri.https(_url, '3/search/movie', {'api_key': _apiKey, 'query': query});

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final results = decodedData['results'];
    return Movies.fromJsonList(results).movies;
  }
}
