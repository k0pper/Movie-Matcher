import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:transparent_image/transparent_image.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../models/movie.dart';

class SwipeMoviesPage extends StatefulWidget {
  SwipeMoviesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SwipeMoviesPageState createState() => _SwipeMoviesPageState();
}

class _SwipeMoviesPageState extends State<SwipeMoviesPage> {
  List<Movie> moviesInStack = [];
  final String baseImageUrl = "http://image.tmdb.org/t/p/w300//";
  CardController controller;
  Movie movieOnTop;

  double likeOpacity = 0;
  double dislikeOpacity = 0;

  @override
  void initState() {
    this.loadMovies().then((movies) {
      setState(() {
        this.moviesInStack = movies;
        this.movieOnTop = this.moviesInStack[0];
        print(this.movieOnTop.name);
      });
    });
    super.initState();
  }

  Future<String> _loadAMoviesAsset() async {
    return await rootBundle.loadString('assets/movies.json');
  }

  /*
  Method that loads mocked Movies in assets/movies.json.
  Later, replace this method with a real API call
  */
  Future<List<Movie>> loadMovies() async {
    String jsonString = await _loadAMoviesAsset();
    final jsonResponse = json.decode(jsonString);
    final List<dynamic> items = jsonResponse['results'];
    final moviesList = items.map((e) => Movie.fromJson(e)).toList();
    return moviesList;
  }

  Future wait(int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }

  void _updateLikeOpacity(double x) {
    setState(() {
      if (x == 0) {
        this.likeOpacity = 0;
        return;
      } else if (x >= 5) {
        this.likeOpacity = 1;
        return;
      }
      this.likeOpacity = x * 0.2;
    });
  }

  void _updateDislikeOpacity(double x) {
    setState(() {
      if (x == 0) {
        this.dislikeOpacity = 0;
        return;
      } else if (x <= -5) {
        this.dislikeOpacity = 1;
        return;
      }
      this.dislikeOpacity = -x * 0.2;
    });
  }

  Color _getRatingColor(double movieRating) {
    return Color.lerp(
        Colors.red[300], Colors.lightGreenAccent, movieRating / 10);
  }

  void _syncMovieArrayWithCardStack(int index) {
    Movie swipedMovie = this.moviesInStack.elementAt(index);
    this.movieOnTop = this.moviesInStack[index + 1];
    this
        .moviesInStack
        .removeWhere((element) => element.name == swipedMovie.name);
    print(this.movieOnTop.name);
  }

  void onSwipeComplete(CardSwipeOrientation orientation, int index) {
    if ([CardSwipeOrientation.RIGHT, CardSwipeOrientation.LEFT]
        .contains(orientation)) {
      this.likeOpacity = 0;
      this.dislikeOpacity = 0;
      setState(() {
        this._syncMovieArrayWithCardStack(index);
      });
    }
    if (orientation == CardSwipeOrientation.RECOVER) {
      this.likeOpacity = 0;
      this.dislikeOpacity = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.moviesInStack.length == 0)
      return Scaffold(
          backgroundColor: Theme.of(context).primaryColorLight,
          body: Center(
              child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor)));

    return new Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: AutoSizeText(
                            this.movieOnTop.name,
                            style: TextStyle(fontSize: 32, color: Colors.white),
                            maxLines: 1,
                          ),
                        ),
                        Text(this.movieOnTop.releaseDate,
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)),
                      ],
                    ),
                    CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 5.0,
                      percent: this.movieOnTop.rating / 10,
                      center: Text(
                        this.movieOnTop.rating.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      progressColor: _getRatingColor(this.movieOnTop.rating),
                      backgroundColor: Colors.grey[800].withOpacity(0.5),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.70,
            child: GestureDetector(
              onTapUp: (tapUpDetails) {
                print(tapUpDetails);
              },
              child: TinderSwapCard(
                animDuration: 200,
                swipeUp: false,
                swipeDown: false,
                orientation: AmassOrientation.BOTTOM,
                totalNum: this.moviesInStack.length,
                stackNum: 6,
                swipeEdge: 5.0,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.width * 0.9,
                minWidth: MediaQuery.of(context).size.width * 0.8,
                minHeight: MediaQuery.of(context).size.width * 0.8,
                cardBuilder: (context, index) {
                  return Card(
                    child: GestureDetector(
                      onTapUp: (tapUpDetails) {
                        print(tapUpDetails);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(this.baseImageUrl +
                                        moviesInStack
                                            .elementAt(index)
                                            .backdropPath))),
                            child: ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                  color: Colors.black.withOpacity(0),
                                ),
                              ),
                            ),
                          ),
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: this.baseImageUrl +
                                this.moviesInStack.elementAt(index).posterPath,
                          ),
                          Opacity(
                            opacity: this.likeOpacity,
                            child: Text("LIKE",
                                style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green)),
                          ),
                          Opacity(
                            opacity: this.dislikeOpacity,
                            child: Text("DISLIKE",
                                style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.red)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                cardController: controller = CardController(),
                swipeUpdateCallback:
                    (DragUpdateDetails details, Alignment align) {
                  if (align.x < 0) this._updateDislikeOpacity(align.x);
                  if (align.x > 0) this._updateLikeOpacity(align.x);
                },
                swipeCompleteCallback: onSwipeComplete,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
