import 'package:flutter/material.dart';

import '../models/actors.dart';
import '../models/movies.dart';
import '../providers/movies_provider.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie _movie = ModalRoute.of(context)?.settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          appBar(context, _movie),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 10),
            movieGeneralInfo(context, _movie),
            movieDescription(context, _movie),
            actorsInfo(context, _movie)
          ]))
        ],
      ),
    );
  }

  Widget appBar(BuildContext context, Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.lightBlueAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: FadeInImage(
            fit: BoxFit.cover,
            placeholder: const AssetImage('assets/imgs/no-image.png'),
            image: NetworkImage(
              movie.getBackgroundImage(),
            )),
      ),
    );
  }

  Widget movieGeneralInfo(BuildContext context, Movie movie) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: NetworkImage(movie.getPosterImage()),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  const Icon(Icons.star_border),
                  Text(
                    movie.voteAverage.toString(),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget movieDescription(BuildContext context, Movie movie) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Text(
        movie.overview,
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.justify,
      ),
    );
  }
}

Widget actorsInfo(BuildContext context, Movie movie) {
  final moviesProvider = MoviesProvider();
  return FutureBuilder(
    future: moviesProvider.getCastForMovie(movie.id),
    builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
      if (snapshot.hasData) {
        return SizedBox(
          height: 200,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.3, initialPage: 1),
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                          height: 150,
                          fit: BoxFit.cover,
                          placeholder:
                              const AssetImage('assets/imgs/no-image.png'),
                          image: NetworkImage(
                              snapshot.data![index].getProfileImage())),
                    ),
                    Text(
                      snapshot.data![index].name,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              );
            },
          ),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}
