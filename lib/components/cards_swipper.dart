import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../models/movies.dart';

class CardsSwipper extends StatelessWidget {
  const CardsSwipper({Key? key, required this.movies}) : super(key: key);
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: _screenSize.height * 0.4,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.80,
        itemHeight: _screenSize.height * 0.4,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(
                movies[index].getPosterImage(),
              ),
              placeholder: const AssetImage('assets/imgs/no-image.png'),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
