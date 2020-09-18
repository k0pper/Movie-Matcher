import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:swipecards/pages/authpage.dart';
import 'package:swipecards/pages/groupspage.dart';
import 'package:swipecards/pages/rootpage.dart';
import 'package:swipecards/pages/swipemoviespage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color primaryColor = Color(0xFFF46036);
  Color secondaryColor = Colors.indigo[900];
  PageController _pageController;
  int _page = 2;

  Curve animationCurve = Curves.easeInCubic;
  int animationDuration = 200;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      this._page = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: this.animationDuration),
          curve: this.animationCurve);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Roboto',
          primaryColor: primaryColor,
          primaryColorLight: secondaryColor,
        ),
        home: RootPage());
  }
}
