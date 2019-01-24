import 'package:flutter/material.dart';
import 'theme.dart' as CustomTheme;
import 'movie_summary.dart';

class MovieDetail extends StatefulWidget {
  final int id;
  final String title;
  final int vote_count;
  final dynamic vote_average;
  final dynamic popularity;
  final String poster_path;
  final String backdrop_path;
  final String overview;
  final String release_date;

  MovieDetail(
      {this.id,
      this.title,
      this.vote_count,
      this.vote_average,
      this.popularity,
      this.poster_path,
      this.backdrop_path,
      this.overview,
      this.release_date});
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    final backgroundHeight = (MediaQuery.of(context).size.height) * 0.7;
    final gradientHeight = 100.0;
    Container _getBackground() {
      return new Container(
        constraints: BoxConstraints.expand(height: backgroundHeight),
        child: ClipRect(
          child: new Image(
            image: new NetworkImage(
              "https://image.tmdb.org/t/p/w780${widget.backdrop_path}",
            ),
            height: backgroundHeight,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Container _getGradient() {
      return new Container(
        height: gradientHeight,
        margin: EdgeInsets.only(top: backgroundHeight - gradientHeight),
        decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: <Color>[
              CustomTheme.Colors.darkPurple.withOpacity(0),
              CustomTheme.Colors.darkPurple.withOpacity(1),
            ],
                stops: [
              0.0,
              0.9
            ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0))),
      );
    }

    Widget _getContent() {
      return ListView(
        padding: new EdgeInsets.only(top: 200.0),
        children: <Widget>[
          MovieSummary.expand(widget.id, widget.vote_count, widget.vote_average,
              widget.title, widget.popularity, widget.poster_path),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text('Release date: ${widget.release_date}'),
                new SizedBox(
                  height: 10.0,
                ),
                new Text(
                  widget.overview,
                  style: CustomTheme.Style.baseTextStyle,
                ),
              ],
            ),
          )
        ],
      );
    }

    return new Scaffold(
      body: SafeArea(
        top: false,
        child: Container(
          constraints: BoxConstraints.expand(),
          color: CustomTheme.Colors.darkPurple,
          child: new Stack(
            children: <Widget>[
              _getBackground(),
              _getGradient(),
              _getContent(),
              new BackButton(
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
