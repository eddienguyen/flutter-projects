import 'package:flutter/material.dart';
import 'dart:core';
import 'package:movie_db/src/ui/widgets/star_rating.dart';
import 'theme.dart' as Theme;

class MovieSummary extends StatelessWidget {
  final int id;
  final int vote_count;
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

  // is on detail or on list
  final bool expanded;

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
      {this.expanded = false});

  MovieSummary.expand(
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
  ) : expanded = true;

  @override
  Widget build(BuildContext context) {
    // covert rating out of 10 to out of 5
    final rating = num.parse((this.vote_average / 10 * 5).toStringAsFixed(1));

    final movieCardContent = new Container(
      constraints: BoxConstraints.expand(),
      padding: expanded
          ? new EdgeInsets.only(top: 100.0)
          : new EdgeInsets.fromLTRB(112.0, 10.0, 10.0, 10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            expanded ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: <Widget>[
          new Text(this.title,
              style: expanded
                  ? Theme.Style.movieTitleTextStyle.copyWith(fontSize: 24.0)
                  : Theme.Style.movieTitleTextStyle),
          new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new StarRating(
                rating: rating,
                color: Theme.Colors.gold,
              ),
              new Text(
                rating.toString(),
                style: Theme.Style.regularTextStyle.copyWith(
                    color: Theme.Colors.gold,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0),
              ),
            ],
          ),
          expanded
              ? Offstage()
              : new Expanded(
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
      height: expanded ? 250.0 : 124.0,
      margin: EdgeInsets.only(top: expanded ? 200 : 50.0),
      decoration: expanded
          ? new BoxDecoration()
          : new BoxDecoration(
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
      bottom: expanded ? null : 0.0,
      child: Container(
        alignment: FractionalOffset.center,
        decoration: expanded
            ? null
            : new BoxDecoration(boxShadow: <BoxShadow>[
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
              width: expanded ? 185.0 : 92.0,
              image: new NetworkImage(
                  'https://image.tmdb.org/t/p/w185${this.poster_path}'),
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
