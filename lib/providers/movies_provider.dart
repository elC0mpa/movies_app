import 'dart:convert';

import 'package:movies_app/models/movies.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  final String _apiKey = '371e418316bc84db563e2c57ff2926d0';
  final String _url = 'api.themoviedb.org';

  Future<List<Movie>> getPlayingNow() async {
    final url = Uri.https(_url, '3/movie/now_playing', {'api_key': _apiKey});

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final results = decodedData['results'];
    return Movies.fromJsonList(results).movies;
  }

  Future<List<Movie>> getPopular() async {
    final url = Uri.https(_url, '3/movie/popular', {'api_key': _apiKey});

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final results = decodedData['results'];
    return Movies.fromJsonList(results).movies;
  }
}
