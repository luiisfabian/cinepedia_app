import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class MoviesSlideShow extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideShow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(color: Colors.black, activeColor: colors.primaryColor)),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return SliderWidget(
            movie: movie,
          );
        },
      ),
    );
  }
}

class SliderWidget extends StatelessWidget {
  final Movie movie;
  const SliderWidget({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, blurRadius: 10, offset: Offset(0, 10))
        ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return CircularProgressIndicator();
              }

              return FadeIn(
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
