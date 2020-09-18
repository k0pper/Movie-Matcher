import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:transparent_image/transparent_image.dart';

import '../models/movie.dart';

class SwipeMoviesPage extends StatefulWidget {
  SwipeMoviesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SwipeMoviesPageState createState() => _SwipeMoviesPageState();
}

class _SwipeMoviesPageState extends State<SwipeMoviesPage> {
  List<Movie> movies = [];
  final String baseImageUrl = "http://image.tmdb.org/t/p/w500/";

  double likeOpacity = 0;
  double dislikeOpacity = 0;

  @override
  void initState() {
    this.loadMovies().then((movies) {
      print("Movies loaded");
      setState(() {
        this.movies = movies;
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

  void updateLikeOpacity(double x) {
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

  void updateDislikeOpacity(double x) {
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

  @override
  Widget build(BuildContext context) {
    if (this.movies.length == 0)
      return Scaffold(
          backgroundColor: Theme.of(context).primaryColorLight,
          body: Center(
              child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor)));
    CardController controller;
    return new Container(
      child: new Center(
        child: Container(
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
              totalNum: this.movies.length,
              stackNum: 6,
              swipeEdge: 5.0,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              maxHeight: MediaQuery.of(context).size.width * 0.9,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              minHeight: MediaQuery.of(context).size.width * 0.8,
              cardBuilder: (context, index) {
                print(index);
                return Card(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: this.baseImageUrl +
                            this.movies.elementAt(index).posterPath,
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
                );
              },
              cardController: controller = CardController(),
              swipeUpdateCallback:
                  (DragUpdateDetails details, Alignment align) {
                if (align.x < 0) this.updateDislikeOpacity(align.x);
                if (align.x > 0) this.updateLikeOpacity(align.x);
              },
              swipeCompleteCallback:
                  (CardSwipeOrientation orientation, int index) {
                print(this.movies.elementAt(index).name);
                if ([CardSwipeOrientation.RIGHT, CardSwipeOrientation.LEFT]
                    .contains(orientation)) {
                  this.likeOpacity = 0;
                  this.dislikeOpacity = 0;
                }
                if (orientation == CardSwipeOrientation.RECOVER) {
                  this.likeOpacity = 0;
                  this.dislikeOpacity = 0;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
