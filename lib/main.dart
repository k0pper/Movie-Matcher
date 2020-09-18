import 'package:flutter/material.dart';
import 'package:swipecards/pages/authpage.dart';
import 'package:swipecards/pages/rootpage.dart';
import 'package:get_it/get_it.dart';
import 'package:swipecards/services/nav.dart';

GetIt locator = GetIt();
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color primaryColor = Color(0xFFF46036);
  Color secondaryColor = Colors.indigo[900];

  Curve animationCurve = Curves.easeInCubic;
  int animationDuration = 200;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: (routeSettings) {
          switch (routeSettings.name) {
            case 'login':
              return MaterialPageRoute(builder: (context) => AuthPage());
            default:
              return MaterialPageRoute(builder: (context) => AuthPage());
          }
        },
        home: AuthPage());
  }
}
