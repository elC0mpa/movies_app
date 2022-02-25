import 'package:flutter/material.dart';
import '../models/movies.dart';

class Populars extends StatelessWidget {
  const Populars(
      {Key? key, required this.popularMovies, required this.nextPagePopulars})
      : super(key: key);
  final List<Movie> popularMovies;
  final Function nextPagePopulars;

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.3,
    );

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPagePopulars();
      }
    });

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Text(
            'Populars',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: _screenSize.height * 0.25,
            child: PageView.builder(
                pageSnapping: false,
                controller: _pageController,
                itemCount: popularMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  final movie = popularMovies[index];

                  var _popularMovieCard = Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Hero(
                          tag: movie.id,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                              placeholder:
                                  const AssetImage('assets/imgs/no-image.png'),
                              image: NetworkImage(movie.getPosterImage()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          movie.title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  );

                  return GestureDetector(
                    child: _popularMovieCard,
                    onTap: () {
                      Navigator.pushNamed(context, 'movie-details',
                          arguments: popularMovies[index]);
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
