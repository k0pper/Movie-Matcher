import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:transparent_image/transparent_image.dart';

import 'models/movie.dart';

class SwipeMoviesPage extends StatefulWidget {
  SwipeMoviesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SwipeMoviesPageState createState() => _SwipeMoviesPageState();
}

class _SwipeMoviesPageState extends State<SwipeMoviesPage> {
  List<Movie> movies = [];

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
    await wait(3);
    String jsonString = await _loadAMoviesAsset();
    final jsonResponse = json.decode(jsonString);
    final List<dynamic> items = jsonResponse['ITEMS'];
    final moviesList = items.map((e) => Movie.fromJson(e)).toList();
    return moviesList;
  }

  Future wait(int seconds) {
    return new Future.delayed(Duration(seconds: seconds), () => {});
  }

  @override
  Widget build(BuildContext context) {
    if (this.movies.length == 0)
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    CardController controller;
    return new Scaffold(
      body: new Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.70,
          child: new TinderSwapCard(
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
            cardBuilder: (context, index) => Card(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: this.movies.elementAt(index).img,
                  ),
                  Text(
                    this.movies.elementAt(index).name,
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  )
                ],
              ),
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              print(align.x);
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              print(orientation);
            },
          ),
        ),
      ),
    );
  }
}
