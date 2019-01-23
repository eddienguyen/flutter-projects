import 'package:flutter/material.dart';
import 'theme.dart' as Theme;

class MovieSummary extends StatelessWidget {
  final int vote_count;
  final int id;
  // final bool video;
  final dynamic vote_average;
  final String title;
  final dynamic popularity;
  final String poster_path;
  // final String original_language;
  // final String original_title;
  // final List genre_ids;
  // final String backdrop_path;
  // final bool adult;
  // final String overview;
  // final String release_date;

  MovieSummary(
    this.id,
    this.vote_count,
    // this.video,
    this.vote_average,
    this.title,
    this.popularity,
    this.poster_path,
    // this.original_language,
    // this.original_title,
    // this.genre_ids,
    // this.backdrop_path,
    // this.adult,
    // this.overview,
    // this.release_date
  );

  @override
  Widget build(BuildContext context) {
    final movieCardContent = new Container(
      constraints: BoxConstraints.expand(),
      padding: EdgeInsets.only(left: 112.0, top: 10.0, bottom: 10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(this.title, style: Theme.Style.movieTitleTextStyle),
          new Text(
            this.vote_average.toString(),
            style: Theme.Style.regularTextStyle.copyWith(
                color: Theme.Colors.gold,
                fontWeight: FontWeight.w400,
                fontSize: 12.0),
          ),
          new Text(
            'from ${this.vote_count} votes',
            style: Theme.Style.baseTextStyle,
          ),
          new Expanded(
            child: SizedBox(
              height: 15.0,
            ),
          ),
          new Text(
            'popularity: ${this.popularity}',
            style: Theme.Style.baseTextStyle,
          ),
        ],
      ),
    );

    final movieCard = new Container(
      height: 124.0,
      margin: EdgeInsets.only(top: 50.0),
      decoration: BoxDecoration(
        color: Theme.Colors.purple,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0))
        ],
      ),
      child: movieCardContent,
    );

    final movieThumbnail = new Positioned(
      bottom: 0.0,
      child: Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.black38,
              blurRadius: 2.0,
              offset: new Offset(0.0, 2.0))
        ]),
        margin: const EdgeInsets.all(10.0),
        child: Hero(
          tag: 'movie-hero-${this.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: new Image(
              width: 92.0,
              image: new NetworkImage(
                  'https://image.tmdb.org/t/p/w92${this.poster_path}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    return new Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: new Stack(
        children: <Widget>[movieCard, movieThumbnail],
      ),
    );
  }
}
