import 'package:flutter/material.dart';
import 'package:movie_db/src/models/trailer_model.dart';
import 'theme.dart' as CustomTheme;
import 'movie_summary.dart';
import 'package:movie_db/src/blocs/movie_detail_bloc_provider.dart';

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
  MovieDetailBloc bloc;
  final _trailerController = new PageController();

  @override
  void didChangeDependencies() {
    bloc = MovieDetailBlocProvider.of(context);
    bloc.fetchTrailersById(widget.id);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

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

    trailerItem(TrailerModel data, int index) {
      return Column(
        children: <Widget>[
          Container(
            height: 100.0,
            margin: EdgeInsets.all(5.0),
          ),
          Expanded(
            child: Text(data.results[index].name),
          )
        ],
      );
    }

    Widget _trailerLayout(TrailerModel data) {
      if (data.results.length > 1) {
        // return PageView.builder(
        //   // controller: _trailerController,
        //   itemCount: data.results.length,
        //   // scrollDirection: Axis.horizontal,
        //   // itemBuilder: (BuildContext context, int index) {
        //   //   return trailerItem(data, index);
        //   // },
        //   itemBuilder: (BuildContext context, int index) {
        //     return Flexible(
        //       child: Container(
        //         color: Colors.black,
        //       ),
        //     );
        //   },
        // );
        return Row(
          children: <Widget>[
            new Container(
              child: new Text('test'),
            )
          ],
        );
      } else {
        return trailerItem(data, 0);
      }
    }

    Widget _noTrailer() {
      return Center(
        child: Container(
          child: Text('No trailer available.'),
          height: 100.0,
        ),
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
                new SizedBox(
                  height: 10.0,
                ),
                Text('Trailers: '),
                Expanded(
                  child: StreamBuilder(
                    stream: bloc.movieTrailers,
                    builder: (context,
                        AsyncSnapshot<Future<TrailerModel>> snapshot) {
                      if (snapshot.hasData) {
                        return FutureBuilder(
                          future: snapshot.data,
                          builder: (context,
                              AsyncSnapshot<TrailerModel> itemSnapshot) {
                            if (itemSnapshot.hasData) {
                              if (itemSnapshot.data.results.length > 0) {
                                return _trailerLayout(itemSnapshot.data);
                              } else {
                                return _noTrailer();
                              }
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
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
