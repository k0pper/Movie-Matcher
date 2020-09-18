import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:swipecards/pages/swipemoviespage.dart';

import 'groupspage.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  Color primaryColor = Color(0xFFF46036);
  Color secondaryColor = Colors.indigo[900];
  PageController _pageController;
  int _page = 2;

  Curve animationCurve = Curves.linear;
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
    return Scaffold(
      backgroundColor: secondaryColor,
      bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          height: 50,
          backgroundColor: secondaryColor,
          animationDuration: Duration(milliseconds: this.animationDuration),
          animationCurve: this.animationCurve,
          items: <Widget>[
            Icon(Icons.group, size: 30),
            Icon(Icons.redo, size: 30),
            Icon(Icons.settings, size: 30),
          ],
          onTap: _onItemTapped),
      body: SizedBox.expand(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => this._page = index);
          },
          children: <Widget>[
            GroupsPage(),
            SwipeMoviesPage(),
            Text("third"),
          ],
        ),
      ),
    );
  }
}
