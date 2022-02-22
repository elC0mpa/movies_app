import 'package:flutter/material.dart';
import '../models/movies.dart';
import '../providers/movies_provider.dart';

class Populars extends StatelessWidget {
  Populars({Key? key}) : super(key: key);
  final _moviesProvider = MoviesProvider();
  final List<Movie> _popularMovies = List.empty();

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        child: Column(
            children: [
              Text('Populars', style: Theme.of(context).textTheme.headline4,),
              FutureBuilder(
                  builder: (BuildContext context, AsyncSnapshot<List<Movie>> result) {

                    return Container(
                        height: _screenSize.height * 0.3,
                        child: PageView(
                            
                        ),
                    );
                  },
                  future: _moviesProvider.getPopular(),
              )
            ],
        ),
    )
  }
}
